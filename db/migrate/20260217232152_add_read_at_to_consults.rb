class AddReadAtToConsults < ActiveRecord::Migration[8.0]
  def change
    add_column :consults, :read_at, :datetime
  end
end
