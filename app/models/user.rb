class User < ApplicationRecord
  # --------------------------------------------------
  # Defaults
  # --------------------------------------------------
  after_initialize do
    self.time_zone ||= "Pacific Time (US & Canada)"
  end

  # --------------------------------------------------
  # Devise
  # --------------------------------------------------
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  # --------------------------------------------------
  # Associations
  # --------------------------------------------------
  has_many :asked_consults,
           class_name: "Consult",
           foreign_key: "asked_by_id",
           dependent: :nullify


  has_many :assigned_consults,
           class_name: "Consult",
           foreign_key: "assigned_to_id",
           dependent: :nullify

  has_many :availabilities, dependent: :destroy

  has_many :consult_assignments, dependent: :destroy

  has_many :fbx_neo_consults,
           through: :consult_assignments,
           source: :consult

  accepts_nested_attributes_for :availabilities, allow_destroy: true

  # --------------------------------------------------
  # Roles
  # --------------------------------------------------
  ROLE_ADMIN = "admin"
  ROLE_USER  = "user"

  validates :name, presence: true
  validates :user_role, inclusion: { in: [ ROLE_ADMIN, ROLE_USER ] }
  scope :receiving_consults, -> { where(can_receive_consults: true) }
  # --------------------------------------------------
  # Role helpers
  # --------------------------------------------------
  def admin?; user_role == ROLE_ADMIN; end
  def user?; user_role == ROLE_USER; end
  def role_text; admin? ? "Admin" : "User"; end

  # --------------------------------------------------
  # FBX NEO eligibility
  # --------------------------------------------------
  def eligible_for_fbx_neo?; can_accept_fbx_neo?; end

# --------------------------------------------------
# Class methods
# --------------------------------------------------

def self.eligible_for_consults(exclude_user: nil)
  users = all
  users = users.where.not(id: exclude_user.id) if exclude_user

  # Only select users who can receive consults AND are available + within limits
  users.select do |user|
    user.can_receive_consults? && user.available_now? && user.eligible_by_limits_and_cooldown?
  end
end


  def self.eligible_for_fbx_neo(exclude_user: nil)
  users = where(can_accept_fbx_neo: true)
  users = users.where.not(id: exclude_user.id) if exclude_user

  users.select(&:works_within_next_48_hours?)
  end


  # --------------------------------------------------
  # Availability
  # --------------------------------------------------
  def available_now?
    Time.use_zone(time_zone) do
      now = Time.zone.now
      today = now.wday

      availability = availabilities.find { |a| a.day_of_week == today }
      return false unless availability
      # return false unless availability.start_minute && availability.end_minute
      return false if availability.off?
       # incom times
       return false unless availability.start_minute && availability.end_minute

      now_minutes = now.hour * 60 + now.min
      now_minutes.between?(availability.start_minute, availability.end_minute)
    end
  end

  def works_within_next_48_hours?
    Time.use_zone(time_zone) do
      now = Time.zone.now
      cutoff = now + 48.hours

      availabilities.any? do |a|
        # Skip any incomplete availability
        next false if a.off?
        next false unless a.start_minute && a.end_minute

        # Calculate the next occurrence of this day
        days_ahead = (a.day_of_week - now.wday) % 7
        availability_start = now.beginning_of_day + days_ahead.days + a.start_minute.minutes
        availability_end   = now.beginning_of_day + days_ahead.days + a.end_minute.minutes

        # Check if any part of this availability is within the next 48 hours
        (availability_start..availability_end).overlaps?(now..cutoff)
      end
    end
  end

  def availability_for(day_of_week)
    availabilities.find { |a| a.day_of_week == day_of_week }
  end

  # --------------------------------------------------
  # Eligibility checks
  # --------------------------------------------------
  def eligible_by_limits_and_cooldown?
    Time.use_zone(time_zone) { within_daily_limit? && past_cooldown? }
  end

  def within_daily_limit?
    return true unless daily_consult_limit

    today_range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    assigned_consults.where(assigned_at: today_range).count < daily_consult_limit
  end

  def past_cooldown?
    return true if cooldown_minutes.blank? || cooldown_minutes.zero?

    last_assigned = assigned_consults.maximum(:assigned_at)
    return true unless last_assigned

    last_assigned <= Time.zone.now - cooldown_minutes.minutes
  end

  # --------------------------------------------------
  # Time helpers
  # --------------------------------------------------
  def local_time(time = Time.current)
    time.in_time_zone(time_zone)
  end
end
