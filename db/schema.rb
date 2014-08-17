# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140817212704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "burritos", force: true do |t|
    t.integer  "user_id"
    t.integer  "calorie_log_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "calorie_logs", force: true do |t|
    t.integer  "user_id"
    t.integer  "calories"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "fitbit_date"
  end

  add_index "calorie_logs", ["user_id", "calories"], name: "index_calorie_logs_on_user_id_and_calories", using: :btree
  add_index "calorie_logs", ["user_id", "fitbit_date", "calories"], name: "index_calorie_logs_on_user_id_and_fitbit_date_and_calories", using: :btree

  create_table "ios_device_tokens", force: true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_tokens", force: true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.string   "provider"
    t.hstore   "extra_info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_token"
  end

end
