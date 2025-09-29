class CreateConsults < ActiveRecord::Migration[8.0]
  def change
    create_table :consults do |t|
      t.string :title
      t.text :body
      t.references :asked_by, null: false, foreign_key: { to_table: :users }
      t.references :assigned_to, null: false, foreign_key: { to_table: :users }
      t.integer :status, default: 0
      t.datetime :assigned_at

      t.timestamps
    end
  end
end
