class MakeAssignedToIdNullableForFbxNeo < ActiveRecord::Migration[8.0]
  def change
    change_column_null :consults, :assigned_to_id, true
  end
end
