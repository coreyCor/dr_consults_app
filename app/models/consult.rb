class Consult < ApplicationRecord
  # Associations
  belongs_to :asked_by, class_name: "User"
  belongs_to :assigned_to, class_name: "User", optional: true
  has_one :answer, dependent: :destroy

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

  # Boolean helpers
  def pending?; consult_status == STATUS_PENDING; end
  def answered?; consult_status == STATUS_ANSWERED; end
end
