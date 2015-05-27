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

ActiveRecord::Schema.define(version: 20150526061948) do

  create_table "is_rateable_ratings", force: :cascade do |t|
    t.integer  "rater_id"
    t.integer  "ratee_id"
    t.string   "rater_type"
    t.string   "ratee_type"
    t.integer  "score",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "is_rateable_ratings", ["ratee_id"], name: "index_is_rateable_ratings_on_ratee_id"
  add_index "is_rateable_ratings", ["rater_id"], name: "index_is_rateable_ratings_on_rater_id"
  add_index "is_rateable_ratings", ["score"], name: "index_is_rateable_ratings_on_score"

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
