class ChangeUserRoleToStringInUsers < ActiveRecord::Migration[8.0]
  def up
    change_column :users, :user_role, :string
  end

  def down
    change_column :users, :user_role, :integer
  end
end
