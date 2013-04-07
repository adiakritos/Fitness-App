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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130406221745) do

  create_table "foods", :force => true do |t|
    t.string   "name"
    t.string   "brand"
    t.float    "fat"
    t.float    "carbs"
    t.float    "protien"
    t.string   "type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "meal_id"
  end

  create_table "meals", :force => true do |t|
    t.integer "user_id"
    t.string  "meal_name"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "status_updates", :force => true do |t|
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "user_id"
    t.float    "current_weight"
    t.float    "current_bf_pct"
    t.float    "current_lbm"
    t.float    "current_fat_weight"
    t.float    "change_in_weight"
    t.float    "change_in_bf_pct"
    t.float    "change_in_lbm"
    t.float    "change_in_fat_weight"
    t.float    "total_weight_change"
    t.float    "total_bf_pct_change"
    t.float    "total_lbm_change"
    t.float    "total_fat_change"
  end

  add_index "status_updates", ["user_id", "created_at"], :name => "index_status_updates_on_user_id_and_created_at"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "goal"
    t.string   "measurement"
    t.string   "bmr_formula"
    t.float    "fat_factor"
    t.float    "protein_factor"
    t.float    "deficit_amnt"
    t.float    "target_bf_pct"
    t.float    "activity_factor"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
