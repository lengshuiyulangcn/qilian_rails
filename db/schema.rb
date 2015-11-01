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

ActiveRecord::Schema.define(version: 20151101090424) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.string   "border_left_color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "father_id"
  end

  create_table "categories_posts", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "post_id",     null: false
  end

  add_index "categories_posts", ["category_id"], name: "index_categories_posts_on_category_id"
  add_index "categories_posts", ["post_id"], name: "index_categories_posts_on_post_id"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.string   "address"
    t.datetime "starttime"
    t.datetime "endtime"
    t.text     "description"
    t.string   "price"
    t.string   "price_detail"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "content"
  end

  create_table "entries", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "course_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "entries", ["course_id"], name: "index_entries_on_course_id"
  add_index "entries", ["user_id"], name: "index_entries_on_user_id"

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "content"
    t.boolean  "available"
    t.datetime "timestart"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
    t.datetime "timeend"
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id"

  create_table "jobs", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "position"
    t.datetime "expire_at"
    t.text     "detail"
    t.string   "step"
    t.text     "target"
    t.text     "schedule"
    t.string   "location"
    t.string   "num"
    t.string   "source_url"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "comp_name"
    t.string   "fakeimage"
  end

  create_table "jobs_labels", id: false, force: :cascade do |t|
    t.integer "job_id",   null: false
    t.integer "label_id", null: false
  end

  add_index "jobs_labels", ["job_id"], name: "index_jobs_labels_on_job_id"
  add_index "jobs_labels", ["label_id"], name: "index_jobs_labels_on_label_id"

  create_table "labels", force: :cascade do |t|
    t.string   "category"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",       null: false
    t.string   "description", null: false
    t.text     "content",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
    t.integer  "view_count"
    t.string   "fakeimage"
  end

  create_table "schedules", force: :cascade do |t|
    t.string   "name"
    t.datetime "datetime_from"
    t.datetime "datetime_to"
    t.string   "address"
    t.integer  "limit"
    t.string   "status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "course_id"
    t.text     "content"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   default: "student"
    t.string   "name"
    t.string   "family_name"
    t.string   "given_name"
    t.string   "phone"
    t.string   "school"
    t.string   "major"
    t.string   "job"
    t.string   "wechat"
    t.string   "line"
    t.string   "gender"
    t.datetime "birthday"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_courses", id: false, force: :cascade do |t|
    t.integer "user_id",   null: false
    t.integer "course_id", null: false
  end

  add_index "users_courses", ["course_id"], name: "index_users_courses_on_course_id"
  add_index "users_courses", ["user_id"], name: "index_users_courses_on_user_id"

end
