class Initial < ActiveRecord::Migration
  def self.up
    create_table "plans", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "features", :force => true do |t|
      t.string   "name"
      t.integer  "plan_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "scenarios", :force => true do |t|
      t.string   "name"
      t.string   "setup"
      t.integer  "plan_id"
      t.integer  "feature_id"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "steps", :force => true do |t|
      t.text     "description"
      t.text     "expected"
      t.integer  "scenario_id"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  end

  def self.down
    drop_table :plans
    drop_table :features
    drop_table :scenarios
    drop_table :steps
  end
end
