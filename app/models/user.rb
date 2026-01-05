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

  accepts_nested_attributes_for :availabilities, allow_destroy: true

  # --------------------------------------------------
  # Roles
  # --------------------------------------------------
  ROLE_ADMIN = "admin"
  ROLE_USER  = "user"

  validates :name, presence: true
  validates :user_role, inclusion: { in: [ ROLE_ADMIN, ROLE_USER ] }

  # --------------------------------------------------
  # Role helpers
  # --------------------------------------------------
  def admin?
    user_role == ROLE_ADMIN
  end

  def user?
    user_role == ROLE_USER
  end

  def role_text
    admin? ? "Admin" : "User"
  end

  # --------------------------------------------------
  # Class methods
  # --------------------------------------------------
  def self.eligible_for_consults(exclude_user: nil)
    users = all
    users = users.where.not(id: exclude_user.id) if exclude_user

    users.select do |user|
      user.available_now? && user.eligible_by_limits_and_cooldown?
    end
  end

# --------------------------------------------------
# Availability
# --------------------------------------------------
# def available_now?
# Time.use_zone(time_zone) do
#  now   = Time.zone.now
# today = now.wday

# availability = availabilities.find { |a| a.day_of_week == today }
# return false unless availability
# return false unless availability.start_time && availability.end_time

# now_minutes = now.hour * 60 + now.min

# start_minutes =
#    availability.start_time.hour * 60 +
#     availability.start_time.min
#
# end_minutes =
#    availability.end_time.hour * 60 +
#     availability.end_time.min
#
#  now_minutes.between?(start_minutes, end_minutes)
# end
# end

def available_now?
  Time.use_zone(time_zone) do
    now = Time.zone.now
    today = now.wday

    availability = availabilities.find { |a| a.day_of_week == today }
    return false unless availability
    return false unless availability.start_minute && availability.end_minute

    now_minutes = now.hour * 60 + now.min

      now_minutes.between?(
      availability.start_minute,
      availability.end_minute
    )
  end
end

  def local_time(time = Time.current)
    time.in_time_zone(time_zone)
  end


  def availability_for(day_of_week)
    availabilities.find { |a| a.day_of_week == day_of_week }
  end

  # --------------------------------------------------
  # Eligibility checks
  # --------------------------------------------------
  def eligible_by_limits_and_cooldown?
    Time.use_zone(time_zone) do
      within_daily_limit? && past_cooldown?
    end
  end

  def within_daily_limit?
    return true unless daily_consult_limit

    today_range =
      Time.zone.now.beginning_of_day..Time.zone.now.end_of_day

    assigned_consults
      .where(assigned_at: today_range)
      .count < daily_consult_limit
  end

  def past_cooldown?
    return true if cooldown_minutes.blank? || cooldown_minutes.zero?

    last_assigned = assigned_consults.maximum(:assigned_at)
    return true unless last_assigned

    last_assigned <= Time.zone.now - cooldown_minutes.minutes
  end
end
# --------------------------------------------------
# Time helpers
# --------------------------------------------------
