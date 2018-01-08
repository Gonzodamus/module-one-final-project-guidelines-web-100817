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

ActiveRecord::Schema.define(version: 4) do

  create_table "inspection_violations", force: :cascade do |t|
    t.integer "inspection_id"
    t.integer "violation_id"
  end

  create_table "inspections", force: :cascade do |t|
    t.string  "inspection_date"
    t.string  "inspection_type"
    t.string  "restaurant_id"
    t.integer "score"
    t.string  "grade"
    t.string  "grade_date"
    t.string  "action"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "restaurant_id"
    t.string "name"
    t.string "cuisine"
    t.string "zipcode"
    t.string "building"
    t.string "street"
    t.string "phone_number"
  end

  create_table "violations", force: :cascade do |t|
    t.string "violation_code"
    t.string "violation_description"
  end

end
