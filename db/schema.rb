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

ActiveRecord::Schema.define(version: 20150113170231) do

  create_table "beats", id: false, force: true do |t|
    t.integer "zone_id"
    t.integer "beat"
    t.integer "population"
  end

  create_table "beats_pop", id: false, force: true do |t|
    t.string "beat",       limit: 63
    t.string "population", limit: 63
  end

  create_table "crimes", force: true do |t|
    t.string   "crime_id"
    t.integer  "offense_id"
    t.string   "rpt_date"
    t.datetime "occur_date"
    t.string   "occur_time"
    t.string   "beat_id"
    t.string   "location"
    t.string   "MaxOfnum_victims"
    t.string   "Shift"
    t.string   "neighborhood"
    t.string   "x"
    t.string   "y"
    t.string   "crime"
    t.string   "zone_id"
    t.string   "violent"
  end

  create_table "zones", id: false, force: true do |t|
    t.string "zone",       limit: 63
    t.string "population", limit: 63
  end

end
