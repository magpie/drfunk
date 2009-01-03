class AddRequirement < ActiveRecord::Migration
  def self.up
    add_column :scenarios, :requirement, :string
  end

  def self.down
    remove_column :scenarios, :requirement
  end
end
