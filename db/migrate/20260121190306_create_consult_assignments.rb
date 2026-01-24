class CreateConsultAssignments < ActiveRecord::Migration[8.0]
 def change
  create_table :consult_assignments do |t|
    t.references :consult, null: false, foreign_key: true
    t.references :user, null: false, foreign_key: true
    t.datetime :assigned_at, null: false

    t.timestamps
  end

  add_index :consult_assignments, [ :consult_id, :user_id ], unique: true
 end
end
