# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081111042632) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "steps", :force => true do |t|
    t.integer  "position"
    t.text     "description"
    t.text     "verify"
    t.integer  "use_case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "use_cases", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "setup"
    t.boolean  "automated"
    t.integer  "position"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "run_result"
    t.integer  "category_id"
  end

end
