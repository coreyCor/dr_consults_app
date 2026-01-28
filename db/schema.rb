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

ActiveRecord::Schema[8.0].define(version: 2026_01_27_192031) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text "body"
    t.integer "consult_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consult_id"], name: "index_answers_on_consult_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "availabilities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "day_of_week"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "start_time"
    t.time "end_time"
    t.integer "start_minute"
    t.integer "end_minute"
    t.boolean "off", default: false, null: false
    t.index ["user_id"], name: "index_availabilities_on_user_id"
  end

  create_table "consult_assignments", force: :cascade do |t|
    t.bigint "consult_id", null: false
    t.bigint "user_id", null: false
    t.datetime "assigned_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consult_id", "user_id"], name: "index_consult_assignments_on_consult_id_and_user_id", unique: true
    t.index ["consult_id"], name: "index_consult_assignments_on_consult_id"
    t.index ["user_id"], name: "index_consult_assignments_on_user_id"
  end

  create_table "consults", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "asked_by_id", null: false
    t.integer "assigned_to_id"
    t.integer "consult_status"
    t.datetime "assigned_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "consult_type", default: "standard", null: false
    t.index ["asked_by_id"], name: "index_consults_on_asked_by_id"
    t.index ["assigned_to_id"], name: "index_consults_on_assigned_to_id"
    t.index ["consult_type"], name: "index_consults_on_consult_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "user_role", default: "user"
    t.integer "daily_consult_limit"
    t.integer "cooldown_minutes"
    t.time "available_start_time"
    t.time "available_end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time_zone"
    t.boolean "can_accept_fbx_neo", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "consults"
  add_foreign_key "answers", "users"
  add_foreign_key "availabilities", "users"
  add_foreign_key "consult_assignments", "consults"
  add_foreign_key "consult_assignments", "users"
  add_foreign_key "consults", "users", column: "asked_by_id"
  add_foreign_key "consults", "users", column: "assigned_to_id"
end
