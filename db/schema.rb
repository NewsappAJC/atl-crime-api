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

ActiveRecord::Schema.define(version: 20141210232117) do

  create_table "beats", id: false, force: true do |t|
    t.string "zone"
    t.string "beat"
  end

  create_table "crimes", force: true do |t|
    t.string   "MI_PRINX"
    t.integer  "offense_id"
    t.string   "rpt_date"
    t.datetime "occur_date"
    t.string   "occur_time"
    t.string   "poss_date"
    t.string   "poss_time"
    t.string   "beat"
    t.string   "location"
    t.string   "MaxOfnum_victims"
    t.string   "Shift"
    t.string   "UC2_Literal"
    t.string   "neighborhood"
    t.string   "x"
    t.string   "y"
    t.string   "crime"
    t.string   "zone"
    t.string   "violent"
  end

  create_table "neighborhoods", id: false, force: true do |t|
    t.string "zone"
    t.string "beat"
    t.string "neighborhood"
  end

  create_table "totals", id: false, force: true do |t|
    t.integer "YEAR(occur_date)"
    t.integer "MONTH(occur_date)"
    t.integer "date_count",        limit: 8, default: 0, null: false
  end

  create_table "zone_counts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zones", id: false, force: true do |t|
    t.string "zone"
  end

end
