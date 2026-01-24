class AddConsultTypeToConsults < ActiveRecord::Migration[8.0]
  def change
  add_column :consults, :consult_type, :string, null: false, default: "standard"
  add_index  :consults, :consult_type
  end
end
