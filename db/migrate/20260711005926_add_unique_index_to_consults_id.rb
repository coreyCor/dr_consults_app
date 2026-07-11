class AddUniqueIndexToConsultsId < ActiveRecord::Migration[8.0]
  def change
    add_index :consults, :id, unique: true, if_not_exists: true
  end
end
