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

ActiveRecord::Schema.define(version: 20141215162542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "default_allowance_deductions", force: true do |t|
    t.integer  "employee_master_id"
    t.integer  "arrears_of_salary"
    t.integer  "incentive_payment"
    t.integer  "loyalty_deposit"
    t.integer  "grade_allowance"
    t.integer  "performance_bonus"
    t.integer  "additional_allowance_1"
    t.integer  "additional_allowance_2"
    t.integer  "additional_allowance_3"
    t.integer  "club_contribution"
    t.integer  "professional_tax"
    t.integer  "tds_pm"
    t.integer  "training_cost"
    t.integer  "notice_period_amount"
    t.integer  "additional_deduction_1"
    t.integer  "additional_deduction_2"
    t.integer  "additional_deduction_3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

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
    t.string   "email"
    t.date     "date_of_birth"
    t.string   "father_or_husband_name"
    t.string   "relation"
    t.date     "resignation_date"
    t.string   "reason_for_resignation"
    t.integer  "basic"
    t.string   "status"
  end

  add_index "employee_masters", ["code"], name: "index_employee_masters_on_code", using: :btree
  add_index "employee_masters", ["name"], name: "index_employee_masters_on_name", using: :btree

  create_table "employer_contributions", force: true do |t|
    t.integer "payslip_id"
    t.integer "employee_master_id"
    t.integer "pf"
    t.integer "bonus_payment"
    t.date    "generated_date"
  end

  create_table "job_runs", force: true do |t|
    t.string   "job_code"
    t.datetime "started_on"
    t.datetime "finished_on"
    t.string   "status"
    t.integer  "scrolled_by"
    t.date     "job_date"
  end

  create_table "leave_encashments", force: true do |t|
    t.integer  "employee_master_id"
    t.date     "date"
    t.integer  "no_of_leaves_to_be_encashed"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_bills", force: true do |t|
    t.integer "employee_master_id"
    t.integer "salary_tax_id"
    t.integer "amount"
    t.string  "bill_no"
    t.date    "bill_date"
    t.string  "attachment"
  end

  create_table "medical_insurances", force: true do |t|
    t.integer "employee_master_id"
    t.integer "salary_tax_id"
    t.integer "amount"
    t.string  "bill_no"
    t.date    "bill_date"
    t.boolean "parent_included"
    t.boolean "parent_senior_citizen"
    t.string  "attachement"
  end

  create_table "payslip_additional_fields_labels", force: true do |t|
    t.integer "payslip_id"
    t.string  "additional_allowance_1"
    t.string  "additional_allowance_2"
    t.string  "additional_allowance_3"
    t.string  "additional_deduction_1"
    t.string  "additional_deduction_2"
    t.string  "additional_deduction_3"
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
    t.integer  "professional_tax"
    t.integer  "tds_pm"
    t.integer  "training_cost"
    t.integer  "salary_advance"
    t.integer  "additional_deduction_1"
    t.integer  "additional_deduction_2"
    t.integer  "additional_deduction_3"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notice_period_amount"
    t.integer  "voluntary_pf_contribution"
  end

  create_table "pf_statements", force: true do |t|
    t.integer  "employee_master_id"
    t.integer  "payslip_id"
    t.integer  "epf_wages"
    t.integer  "eps_wages"
    t.integer  "epf_ee_share"
    t.integer  "epf_ee_remitted"
    t.integer  "eps_due"
    t.integer  "eps_remitted"
    t.integer  "diff_epf_and_eps"
    t.integer  "diff_remitted"
    t.integer  "n"
    t.integer  "refund_adv",         default: 0
    t.integer  "arrear_epf",         default: 0
    t.integer  "arrear_epf_ee",      default: 0
    t.integer  "arrear_epf_er",      default: 0
    t.integer  "arrear_eps",         default: 0
    t.integer  "job_run_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reminders", force: true do |t|
    t.string "description"
    t.date   "created_date"
    t.string "occurrence"
    t.date   "previous_resolution_date"
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
    t.string   "break_up_type"
  end

  create_table "salary_taxes", force: true do |t|
    t.integer  "employee_master_id"
    t.string   "financial_year"
    t.integer  "rent_paid"
    t.integer  "rent_per_month"
    t.string   "rent_receipt"
    t.integer  "standard_deduction"
    t.integer  "home_loan_amount"
    t.string   "home_loan_document"
    t.integer  "rent_received"
    t.integer  "other_tax"
    t.integer  "total_tax_projection"
    t.integer  "tax_paid"
    t.integer  "educational_cess"
    t.integer  "surcharge"
    t.integer  "atg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "savings", force: true do |t|
    t.integer "employee_master_id"
    t.integer "salary_tax_id"
    t.string  "saving_type"
    t.integer "amount"
    t.string  "bill_no"
    t.date    "bill_date"
    t.string  "attachement"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

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
