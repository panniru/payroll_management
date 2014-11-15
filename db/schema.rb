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

ActiveRecord::Schema.define(version: 20141113092340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "department_masters", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designation_masters", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_masters", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "designation_master_id"
    t.integer  "department_master_id"
    t.string   "gender"
    t.string   "initials"
    t.string   "qualification"
    t.date     "date_of_joining"
    t.date     "probation_date"
    t.date     "confirmation_date"
    t.string   "p_f_no"
    t.string   "bank_name"
    t.string   "account_number"
    t.string   "pan"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
