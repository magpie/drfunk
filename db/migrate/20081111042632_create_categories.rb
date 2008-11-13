class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.integer :plan_id

      t.timestamps
    end

    add_column :use_cases, :category_id, :integer
  end

  def self.down
    drop_table :categories
  end
end
