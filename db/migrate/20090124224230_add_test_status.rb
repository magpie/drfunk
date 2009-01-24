class AddTestStatus < ActiveRecord::Migration
  def self.up
    add_column :scenarios, :result, :string
  end

  def self.down
  end
end
