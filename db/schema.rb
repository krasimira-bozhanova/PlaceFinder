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

ActiveRecord::Schema.define(version: 20140203161700) do

  create_table "addresses", force: true do |t|
    t.integer "residential_complex_id", null: false
    t.string  "street",                 null: false
    t.integer "street_number",          null: false
    t.integer "place_id"
  end

  create_table "comments", force: true do |t|
    t.integer  "place_id", null: false
    t.integer  "user_id",  null: false
    t.text     "comment",  null: false
    t.datetime "date",     null: false
  end

  create_table "favourites", force: true do |t|
    t.integer "user_id",  null: false
    t.integer "place_id", null: false
  end

  create_table "pictures", force: true do |t|
    t.integer "place_id",     null: false
    t.string  "picture_path"
  end

  create_table "places", force: true do |t|
    t.string   "name",                   null: false
    t.text     "description"
    t.integer  "type_id",                null: false
    t.float    "user_rating"
    t.integer  "address_id",             null: false
    t.datetime "date",                   null: false
    t.integer  "residential_complex_id", null: false
    t.string   "main_picture_path",      null: false
  end

  create_table "ratings", force: true do |t|
    t.integer "place_id", null: false
    t.integer "user_id",  null: false
    t.float   "value",    null: false
  end

  create_table "residential_complexes", force: true do |t|
    t.string "name", null: false
  end

  create_table "types", force: true do |t|
    t.string "name",        null: false
    t.string "plural_name", null: false
  end

  create_table "users", force: true do |t|
    t.string  "username", null: false
    t.string  "name",     null: false
    t.string  "password", null: false
    t.boolean "login",    null: false
    t.boolean "admin",    null: false
  end

end
