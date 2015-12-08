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

ActiveRecord::Schema.define(version: 20151207154710) do

  create_table "participants", force: :cascade do |t|
    t.string   "name"
    t.string   "bib_number"
    t.integer  "wave_number"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
  end

  add_index "participants", ["deleted_at"], name: "index_participants_on_deleted_at"

  create_table "rank_participants", force: :cascade do |t|
    t.integer  "rank"
    t.string   "name"
    t.string   "bib_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "rank_participants", ["deleted_at"], name: "index_rank_participants_on_deleted_at"

  create_table "ranks", force: :cascade do |t|
    t.integer  "rank"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "ranks", ["deleted_at"], name: "index_ranks_on_deleted_at"

  create_table "waves", force: :cascade do |t|
    t.integer  "wave_number"
    t.datetime "start_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
  end

  add_index "waves", ["deleted_at"], name: "index_waves_on_deleted_at"

end
