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

ActiveRecord::Schema[8.0].define(version: 2025_09_03_005931) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "athlete_matches", force: :cascade do |t|
    t.bigint "athlete_id", null: false
    t.bigint "match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_athlete_matches_on_athlete_id"
    t.index ["match_id"], name: "index_athlete_matches_on_match_id"
  end

  create_table "athletes", force: :cascade do |t|
    t.string "name"
    t.bigint "phone"
    t.date "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.string "description"
    t.float "unit_value"
    t.date "date"
  end

  create_table "incomes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.float "unit_value"
    t.date "date"
  end

  create_table "matches", force: :cascade do |t|
    t.date "date"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.date "date"
    t.string "status"
    t.bigint "athlete_id", null: false
    t.bigint "match_id", null: false
    t.text "description"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_payments_on_athlete_id"
    t.index ["match_id"], name: "index_payments_on_match_id"
  end

  add_foreign_key "athlete_matches", "athletes"
  add_foreign_key "athlete_matches", "matches"
  add_foreign_key "payments", "athletes"
  add_foreign_key "payments", "matches"
end
