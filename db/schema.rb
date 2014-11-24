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

ActiveRecord::Schema.define(version: 20141124055048) do

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
    t.integer  "managed_by"
  end

  create_table "employee_advance_payments", force: true do |t|
    t.integer  "employee_master_id"
    t.date     "payment_date"
    t.integer  "amount_in_rupees"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_leaves", force: true do |t|
    t.integer  "employee_master_id"
    t.string   "month"
    t.integer  "lop"
    t.integer  "days_worked"
    t.integer  "working_days"
    t.integer  "sl"
    t.integer  "pl"
    t.integer  "cl"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.date     "entered_date"
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
    t.integer  "ctc"
  end

  create_table "leave_encashments", force: true do |t|
    t.string   "employee_master_id"
    t.string   "integer"
    t.string   "year"
    t.string   "string"
    t.string   "no_of_leaves_to_be_encashed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payslips", force: true do |t|
    t.integer  "employee_master_id"
    t.date     "generated_date"
    t.integer  "basic"
    t.integer  "hra"
    t.integer  "conveyance_allowance"
    t.integer  "city_compensatory_allowance"
    t.integer  "special_allowance"
    t.integer  "loyalty_allowance"
    t.integer  "medical_allowance"
    t.integer  "arrears_of_salary"
    t.integer  "incentive_payment"
    t.integer  "loyalty_deposit"
    t.integer  "grade_allowance"
    t.integer  "leave_settlement"
    t.integer  "performance_bonus"
    t.integer  "annual_bonus"
    t.integer  "additional_allowance_1"
    t.integer  "additional_allowance_2"
    t.integer  "additional_allowance_3"
    t.integer  "pf"
    t.integer  "club_contribution"
    t.integer  "proffesional_tax"
    t.integer  "tds_pm"
    t.integer  "training_cost"
    t.integer  "salary_advance"
    t.integer  "additional_deduction_1"
    t.integer  "additional_deduction_2"
    t.integer  "additional_deduction_3"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "role"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salary_break_ups", force: true do |t|
    t.string   "component"
    t.string   "component_code"
    t.float    "criteria"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
