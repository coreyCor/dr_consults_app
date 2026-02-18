class Consult < ApplicationRecord
  # Associations
  belongs_to :asked_by, class_name: "User"
  belongs_to :assigned_to, class_name: "User", optional: true
  has_one :answer, dependent: :destroy
  has_many :notifications, dependent: :destroy
  after_commit :broadcast_assigned_consult, on: [ :create, :update ]

  # new for FBX_NEOS
  has_many :consult_assignments, dependent: :destroy
  has_many :assigned_users, through: :consult_assignments, source: :user

  # Status const
  STATUS_PENDING = "pending"
  STATUS_ANSWERED = "answered"

  # Scopes
  scope :assigned_to_user, ->(user) { where(assigned_to_id: user.id) }
  scope :asked_by_user, ->(user) { where(asked_by_id: user.id) }
  scope :pending, -> { where(consult_status: STATUS_PENDING) }
  scope :answered, -> { where(consult_status: STATUS_ANSWERED) }

  scope :asked_today_by_user, ->(user) {
    where(asked_by_id: user.id)
      .where(created_at: Time.current.beginning_of_day..Time.current.end_of_day)
  }

  scope :assigned_today_to_user, ->(user) {
    where(assigned_to_id: user.id)
      .where(created_at: Time.current.beginning_of_day..Time.current.end_of_day)
  }

  # Validations
  validates :title, presence: true
  validates :body, presence: true

  # something here is wrong TODO Fix idiot
  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.consult_status ||= STATUS_PENDING
  end

  # For me
  def status_text
    case consult_status
    when STATUS_PENDING then "Pending"
    when STATUS_ANSWERED then "Answered"
    else "Unknown"      # all unknows
    end
  end
  STANDARD = "standard"
  FBX_NEO  = "fbx_neo"

def fbx_neo?
  consult_type == "fbx_neo"
end

def standard?
  consult_type == STANDARD
end

def unread_for?(user)
  assigned_to_id == user&.id && read_at.nil?
end

  def mark_as_read!
    update_column(:read_at, Time.current) if read_at.nil?
  end









def assign_users!(users)
  users.each do |user|
    consult_assignments.create!(
      user: user,
      assigned_at: Time.current
    )
  end
end
  # Boolean helpers
  def pending?; consult_status == STATUS_PENDING; end
  def answered?; consult_status == STATUS_ANSWERED; end
end

  private

 def broadcast_assigned_consult
  return unless saved_change_to_assigned_to_id?

  assigned_user = User.find_by(id: assigned_to_id)
  return unless assigned_user

  broadcast_prepend_to(
    "assigned_consults_user_#{assigned_user.id}",
    target: "assigned_consults",
    partial: "consults/consult",
    locals: {
      consult: self,
      viewer: assigned_user
    }
  )
 end
