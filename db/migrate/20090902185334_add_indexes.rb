class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :features, :plan_id
    add_index :scenarios, :plan_id
    add_index :scenarios, :feature_id
    add_index :steps, :scenario_id
  end

  def self.down
    remove_index :features, :plan_id
    remove_index :scenarios, :plan_id
    remove_index :scenarios, :feature_id
    remove_index :steps, :scenario_id
  end
end
