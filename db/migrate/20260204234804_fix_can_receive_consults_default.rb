class FixCanReceiveConsultsDefault < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :can_receive_consults, from: true, to: false
    change_column_null :users, :can_receive_consults, true
  end
end
