class Plan < ActiveRecord::Base
  has_many :scenarios, :order => "position"
  has_many :features
  
  validates_presence_of :name

  def start_test_run
    for scenario in scenarios
      scenario.run_result = Scenario::NO_RESULT 
      scenario.save
    end
  end
end
