class RenameStatusInConsults < ActiveRecord::Migration[8.0]
  def change
    rename_column :consults, :status, :consult_status
  end
end
