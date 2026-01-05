class ChangeAvailabilityTimesToMinutes < ActiveRecord::Migration[8.0]
  def change
    add_column :availabilities, :start_minute, :integer
    add_column :availabilities, :end_minute, :integer

    remove_column :availabilities, :available_start_time, :time
    remove_column :availabilities, :available_end_time, :time
  end
end
