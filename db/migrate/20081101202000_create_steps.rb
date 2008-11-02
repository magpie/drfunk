class CreateSteps < ActiveRecord::Migration
  def self.up
    create_table :steps do |t|
      t.integer :position
      t.text :description
      t.text :verify
      t.integer :use_case_id

      t.timestamps
    end
  end

  def self.down
    drop_table :steps
  end
end
