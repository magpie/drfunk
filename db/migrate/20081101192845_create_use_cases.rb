class CreateUseCases < ActiveRecord::Migration
  def self.up
    create_table :use_cases do |t|
      t.string :name
      t.string :description
      t.string :setup
      t.boolean :automated
      t.integer :position
      t.integer :plan_id

      t.timestamps
    end
  end

  def self.down
    drop_table :use_cases
  end
end
