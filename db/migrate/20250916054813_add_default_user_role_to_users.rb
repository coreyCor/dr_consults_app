class AddDefaultUserRoleToUsers < ActiveRecord::Migration[8.0]
  def change
     change_column_default :users, :user_role, "user"
  end
end
