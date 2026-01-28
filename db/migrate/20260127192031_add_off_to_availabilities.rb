class AddOffToAvailabilities < ActiveRecord::Migration[8.0]
  def change
     add_column :availabilities, :off, :boolean, default: false, null: false
  end
end
