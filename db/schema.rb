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

ActiveRecord::Schema.define(version: 20130913174802) do

  create_table "attendances", force: true do |t|
    t.integer  "user_id"
    t.date     "working_day",  null: false
    t.integer  "working_time", null: false
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendances", ["user_id"], name: "index_attendances_on_user_id", using: :btree
  add_index "attendances", ["working_day", "user_id"], name: "index_attendances_on_working_day_and_user_id", unique: true, using: :btree

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider",    null: false
    t.string   "uid",         null: false
    t.string   "oauth_token", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["uid", "provider"], name: "index_identities_on_uid_and_provider", unique: true, using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name",                   null: false
    t.integer  "role",       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
