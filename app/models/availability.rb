class Availability < ApplicationRecord
  belongs_to :user

  before_validation :coerce_day_of_week
  before_validation :sync_minutes_from_times

  validates :day_of_week, inclusion: { in: 0..6 }

  validates :start_minute, presence: true, unless: :off?
  validates :end_minute, presence: true, unless: :off?

  private

  def coerce_day_of_week
    self.day_of_week = day_of_week.to_i if day_of_week.present?
  end

  def sync_minutes_from_times
    return if off?

    if start_time
      self.start_minute = start_time.hour * 60 + start_time.min
    end

    if end_time
      self.end_minute = end_time.hour * 60 + end_time.min
    end
  end
end
