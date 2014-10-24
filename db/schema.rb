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

ActiveRecord::Schema.define(version: 20141024002239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cohorts", force: true do |t|
    t.string "slug"
    t.string "name"
    t.string "location"
  end

  add_index "cohorts", ["slug"], name: "index_cohorts_on_slug", unique: true, using: :btree

  create_table "group_participations", force: true do |t|
    t.integer "student_id"
    t.integer "group_id"
  end

  add_index "group_participations", ["group_id"], name: "index_group_participations_on_group_id", using: :btree
  add_index "group_participations", ["student_id"], name: "index_group_participations_on_student_id", using: :btree

  create_table "groupings", force: true do |t|
    t.integer "cohort_id"
  end

  add_index "groupings", ["cohort_id"], name: "index_groupings_on_cohort_id", using: :btree

  create_table "groups", force: true do |t|
    t.integer "grouping_id"
  end

  add_index "groups", ["grouping_id"], name: "index_groups_on_grouping_id", using: :btree

  create_table "students", force: true do |t|
    t.integer "cohort_id"
    t.string  "name"
    t.string  "email"
    t.string  "github"
  end

  add_index "students", ["cohort_id"], name: "index_students_on_cohort_id", using: :btree
  add_index "students", ["email"], name: "index_students_on_email", unique: true, using: :btree
  add_index "students", ["github"], name: "index_students_on_github", unique: true, using: :btree

end
