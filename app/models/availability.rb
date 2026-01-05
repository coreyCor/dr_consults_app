class Availability < ApplicationRecord
  belongs_to :user

  # Ensure day_of_week is an integer between 0 (Sunday) and 6 (Saturday)
  before_validation :coerce_day_of_week

  validates :day_of_week, inclusion: { in: 0..6 } # 0=sun -6sat
  validates :start_minute, presence: true
  validates :end_minute, presence: true

 before_validation :sync_minutes_from_times
  private

  def coerce_day_of_week
    self.day_of_week = day_of_week.to_i if day_of_week.present?
  end
  def sync_minutes_from_times
    if start_time
      self.start_minute = start_time.hour * 60 + start_time.min
    end

    if end_time
      self.end_minute = end_time.hour * 60 + end_time.min
    end
  end
end
