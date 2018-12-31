# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_28_203645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blood_compatibilities", force: :cascade do |t|
    t.bigint "donator_id"
    t.bigint "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["donator_id"], name: "index_blood_compatibilities_on_donator_id"
    t.index ["receiver_id"], name: "index_blood_compatibilities_on_receiver_id"
  end

  create_table "blood_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_blood_types_on_name", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.integer "area_code"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.integer "area_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_districts_on_city_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id"
    t.string "ip_address"
    t.string "user_agent"
    t.boolean "is_deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "password_digest"
    t.string "confirm_token"
    t.boolean "phone_confirmed"
    t.boolean "is_donor"
    t.boolean "is_recipient"
    t.bigint "blood_type_id"
    t.bigint "district_id"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blood_type_id"], name: "index_users_on_blood_type_id"
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["confirm_token"], name: "index_users_on_confirm_token", unique: true
    t.index ["district_id"], name: "index_users_on_district_id"
    t.index ["phone"], name: "index_users_on_phone", unique: true
  end

  add_foreign_key "blood_compatibilities", "blood_types", column: "donator_id"
  add_foreign_key "blood_compatibilities", "blood_types", column: "receiver_id"
  add_foreign_key "cities", "countries"
  add_foreign_key "districts", "cities"
  add_foreign_key "sessions", "users"
  add_foreign_key "users", "blood_types"
  add_foreign_key "users", "cities"
  add_foreign_key "users", "districts"
end
