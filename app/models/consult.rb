class Consult < ApplicationRecord
  belongs_to :asked_by, class_name: "User"
  belongs_to :assigned_to, class_name: "User", optional: true
  has_one :answer

  STATUS_PENDING = 0
  STATUS_ANSWERED = 1

  before_create :set_assigned_at, if: -> { assigned_to_id.present? }
  after_initialize :set_default_status, if: :new_record?

  def set_assigned_at
    self.assigned_at ||= Time.current
  end

  def set_default_status
    self.consult_status ||= STATUS_PENDING
  end

  # Helper methods
  def pending?
    consult_status == STATUS_PENDING
  end

  def answered?
    consult_status == STATUS_ANSWERED
  end

  def status_text
    case consult_status
    when STATUS_PENDING then "pending"
    when STATUS_ANSWERED then "answered"
    else "unknown"
    end
  end
end
