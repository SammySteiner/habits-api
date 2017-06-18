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

ActiveRecord::Schema.define(version: 20170606203832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.text     "description"
    t.boolean  "complete",     default: false
    t.datetime "completed_at"
    t.integer  "goal_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["goal_id"], name: "index_actions_on_goal_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_comments_on_plan_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "goals", force: :cascade do |t|
    t.boolean  "complete",     default: false
    t.datetime "completed_at"
    t.integer  "interval"
    t.integer  "plan_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["plan_id"], name: "index_goals_on_plan_id", using: :btree
  end

  create_table "plans", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "repeat"
    t.boolean  "complete",     default: false
    t.datetime "completed_at"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["user_id"], name: "index_plans_on_user_id", using: :btree
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "score"
    t.integer  "user_id"
    t.integer  "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_ratings_on_plan_id", using: :btree
    t.index ["user_id"], name: "index_ratings_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "actions", "goals"
  add_foreign_key "comments", "plans"
  add_foreign_key "comments", "users"
  add_foreign_key "goals", "plans"
  add_foreign_key "plans", "users"
  add_foreign_key "ratings", "plans"
  add_foreign_key "ratings", "users"
end
