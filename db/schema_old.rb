# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_09_14_214404) do
  create_table "answers", force: :cascade do |t|
    t.text "body"
    t.integer "consult_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consult_id"], name: "index_answers_on_consult_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "consults", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "asked_by_id", null: false
    t.integer "assigned_to_id", null: false
    t.integer "status"
    t.datetime "assigned_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asked_by_id"], name: "index_consults_on_asked_by_id"
    t.index ["assigned_to_id"], name: "index_consults_on_assigned_to_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "role", default: 0, null: false
    t.integer "daily_consult_limit"
    t.integer "cooldown_minutes"
    t.time "available_start_time"
    t.time "available_end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "consults"
  add_foreign_key "answers", "users"
  add_foreign_key "consults", "asked_bies"
  add_foreign_key "consults", "assigned_tos"
end
