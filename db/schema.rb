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

ActiveRecord::Schema.define(version: 20140708165305) do

  create_table "clients", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.float    "fat_factor"
    t.float    "protein_factor"
    t.float    "activity_level"
    t.integer  "target_calories"
    t.integer  "trainer_id"
    t.boolean  "status"
    t.integer  "status_update_id"
    t.integer  "meal_id"
    t.integer  "meal_food_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["meal_food_id"], name: "index_clients_on_meal_food_id", using: :btree
  add_index "clients", ["meal_id"], name: "index_clients_on_meal_id", using: :btree
  add_index "clients", ["status_update_id"], name: "index_clients_on_status_update_id", using: :btree

  create_table "foods", force: true do |t|
    t.integer  "meal_id"
    t.integer  "client_id"
    t.string   "type"
    t.string   "name"
    t.string   "brand"
    t.float    "servings"
    t.float    "serving_size"
    t.string   "units"
    t.float    "glycemic_index"
    t.float    "carbs"
    t.float    "protein"
    t.float    "fat"
    t.float    "saturated_fat"
    t.float    "polyunsaturated_fat"
    t.float    "monosaturated_fat"
    t.float    "trans_fat"
    t.float    "cholesterol"
    t.float    "vitamin_a"
    t.float    "vitamin_c"
    t.float    "sodium"
    t.float    "potassium"
    t.float    "dietary_fiber"
    t.float    "sugar"
    t.float    "calcium"
    t.float    "iron"
    t.float    "dynamic_carbs"
    t.float    "dynamic_protein"
    t.float    "dynamic_fat"
    t.float    "dynamic_sodium"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "foods", ["client_id"], name: "index_foods_on_client_id", using: :btree
  add_index "foods", ["meal_id"], name: "index_foods_on_meal_id", using: :btree

  create_table "global_foods", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meals", force: true do |t|
    t.integer "client_id"
    t.integer "meal_food_id"
    t.string  "meal_name"
  end

  add_index "meals", ["client_id"], name: "index_meals_on_client_id", using: :btree
  add_index "meals", ["meal_food_id"], name: "index_meals_on_meal_food_id", using: :btree

  create_table "status_updates", force: true do |t|
    t.integer  "client_id"
    t.string   "phase"
    t.date     "entry_date"
    t.float    "total_weight"
    t.float    "body_fat_pct"
    t.boolean  "temporary"
    t.float    "weight_change"
    t.float    "lbm_change"
    t.float    "fat_change"
    t.float    "bfp_change"
    t.float    "fat_weight"
    t.float    "lbm_weight"
    t.float    "total_lbm_change"
    t.float    "total_fat_change"
    t.float    "total_weight_change"
    t.float    "total_bfp_change"
    t.float    "phase_change_total_weight"
    t.float    "phase_change_lbm_weight"
    t.float    "phase_change_fat_weight"
    t.float    "phase_change_body_fat_pct"
    t.float    "prev_total_weight"
    t.float    "prev_lbm_weight"
    t.float    "prev_fat_weight"
    t.float    "prev_body_fat_pct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "status_updates", ["client_id"], name: "index_status_updates_on_client_id", using: :btree

  create_table "trainers", force: true do |t|
    t.integer  "client_id"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trainers", ["client_id"], name: "index_trainers_on_client_id", using: :btree
  add_index "trainers", ["email"], name: "index_trainers_on_email", unique: true, using: :btree
  add_index "trainers", ["reset_password_token"], name: "index_trainers_on_reset_password_token", unique: true, using: :btree

end
