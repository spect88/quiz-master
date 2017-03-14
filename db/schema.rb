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

ActiveRecord::Schema.define(version: 20170314174257) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "quiz_results", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "quiz_id",    null: false
    t.integer  "score",      null: false
    t.integer  "max_score",  null: false
    t.jsonb    "details",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_results_on_quiz_id", using: :btree
    t.index ["user_id"], name: "index_quiz_results_on_user_id", using: :btree
  end

  create_table "quizzes", force: :cascade do |t|
    t.string   "title",       limit: 256, null: false
    t.text     "description",             null: false
    t.jsonb    "content",                 null: false
    t.integer  "user_id",                 null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["user_id"], name: "index_quizzes_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid",        null: false
    t.string   "provider",   null: false
    t.jsonb    "info",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "quiz_results", "quizzes"
  add_foreign_key "quiz_results", "users"
end
