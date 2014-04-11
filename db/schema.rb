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

ActiveRecord::Schema.define(version: 20140407195908) do

  create_table "crimes", force: true do |t|
    t.integer  "offense_id"
    t.date     "rpt_date"
    t.date     "occur_date"
    t.datetime "occur_time"
    t.date     "poss_date"
    t.datetime "poss_time"
    t.string   "beat"
    t.string   "location"
    t.string   "MaxOfnum_victims"
    t.string   "Shift"
    t.string   "UC2_Literal"
    t.string   "neighborhood"
    t.string   "x"
    t.string   "y"
  end

end
