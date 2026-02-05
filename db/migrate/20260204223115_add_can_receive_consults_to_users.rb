class AddCanReceiveConsultsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :can_receive_consults, :boolean, default: true, null: false
  end
end
