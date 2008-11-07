class AddRunResultToUseCase < ActiveRecord::Migration
  def self.up
    add_column :use_cases, :run_result, :string
  end

  def self.down
    remove_column :use_cases, :run_result
  end
end
