class Plan < ActiveRecord::Base
  has_many :scenarios, :dependent => :destroy
  has_many :features, :dependent => :destroy
  
  validates_presence_of :name
  named_scope :name_sorted, :order => "name"

  def step_count
    step_counter = 0
    scenarios.each do |scenario|
      step_counter += scenario.steps.count  
    end
    step_counter
  end

  def other_scenarios_with_setups(this_scenario)
    scenario_list = []
    scenarios.each do |scenario|
      if scenario != this_scenario && !scenario.setup.nil?
        scenario_list << scenario
      end
    end
    scenario_list
  end
end
