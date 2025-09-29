class User < ApplicationRecord
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :asked_consults, class_name: "Consult", foreign_key: "asked_by_id", dependent: :nullify
  has_many :assigned_consults, class_name: "Consult", foreign_key: "assigned_to_id", dependent: :nullify

  # Roles
  ROLE_ADMIN = "admin"
  ROLE_USER  = "user"

  validates :name, presence: true
  validates :user_role, inclusion: { in: [ ROLE_ADMIN, ROLE_USER ] }

  # Availability scope
  scope :available_for_consult_now, -> {
    now_time = Time.zone.now.strftime("%H:%M:%S")
    where(<<~SQL, now_time, now_time)
      (
        (available_start_time IS NULL AND available_end_time IS NULL)
        OR
        (
          (available_start_time IS NULL OR strftime('%H:%M:%S', available_start_time) <= ?)
          AND
          (available_end_time IS NULL OR strftime('%H:%M:%S', available_end_time) >= ?)
        )
      )
    SQL
  }

  # Eligible users for a new consult
  def self.eligible_for_consults(exclude_user: nil)
    scope = available_for_consult_now
    scope = scope.where.not(id: exclude_user.id) if exclude_user.present?
    scope.select { |u| u.eligible_by_limits_and_cooldown? }
  end

def role_text
  case user_role
  when ROLE_ADMIN
    "Admin"
  when ROLE_USER
    "User"
  else
    "Unknown"
  end
end







  def eligible_by_limits_and_cooldown?
    within_daily_limit? && past_cooldown?
  end

  def within_daily_limit?
    return true if daily_consult_limit.blank?
    assigned_consults.where("DATE(assigned_at) = ?", Date.current).count < daily_consult_limit
  end

  def past_cooldown?
    return true if cooldown_minutes.blank? || cooldown_minutes.zero?
    last_assigned = assigned_consults.maximum(:assigned_at)
    return true if last_assigned.nil?
    last_assigned <= cooldown_minutes.minutes.ago
  end

  # Role helpers
  def admin?; user_role == ROLE_ADMIN; end
  def user?; user_role == ROLE_USER; end
end
