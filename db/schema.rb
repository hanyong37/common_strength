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

ActiveRecord::Schema.define(version: 20161111044039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "type_id"
    t.integer  "store_id"
    t.string   "name"
    t.text     "description"
    t.integer  "status"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "default_capacity"
    t.index ["store_id"], name: "index_courses_on_store_id", using: :btree
    t.index ["type_id"], name: "index_courses_on_type_id", using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "mobile"
    t.string   "weixin"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "store_id"
    t.integer  "membership_type"
    t.date     "membership_duedate"
    t.integer  "membership_remaining_times"
    t.boolean  "is_locked"
    t.string   "token"
    t.index ["store_id"], name: "index_customers_on_store_id", using: :btree
  end

  create_table "operations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "target"
    t.string   "target_id"
    t.string   "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "operation_memo"
    t.integer  "customer_id"
    t.index ["customer_id"], name: "index_operations_on_customer_id", using: :btree
    t.index ["target_id"], name: "index_operations_on_target_id", using: :btree
    t.index ["user_id"], name: "index_operations_on_user_id", using: :btree
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "store_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "capacity"
    t.boolean  "is_published"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["course_id"], name: "index_schedules_on_course_id", using: :btree
    t.index ["store_id"], name: "index_schedules_on_store_id", using: :btree
  end

  create_table "settings", force: :cascade do |t|
    t.integer  "key"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "telphone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainings", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "schedule_id"
    t.integer  "training_status"
    t.integer  "booking_status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["customer_id"], name: "index_trainings_on_customer_id", using: :btree
    t.index ["schedule_id"], name: "index_trainings_on_schedule_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "full_name"
    t.string   "mobile"
    t.string   "weixin"
    t.string   "password_digest"
    t.string   "token"
    t.text     "description"
    t.index ["token"], name: "index_users_on_token", unique: true, using: :btree
  end

end
