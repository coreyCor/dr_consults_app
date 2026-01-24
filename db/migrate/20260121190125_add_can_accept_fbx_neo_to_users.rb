class AddCanAcceptFbxNeoToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :can_accept_fbx_neo, :boolean, null: false, default: false
  end
end
