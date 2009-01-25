class Plan < ActiveRecord::Base
  has_many :scenarios, :dependent => :destroy
  has_many :features, :order => "name", :dependent => :destroy
  
  validates_presence_of :name
  named_scope :name_sorted, :order => "name"

  def step_count
    step_counter = 0
    scenarios.each do |scenario|
      step_counter += scenario.steps.count  
    end
    step_counter
  end

  def percent_tested
    ((scenarios.tested.size.to_f / scenarios.size.to_f) * 100).to_i
  end

  def features_tested
    tested = []
    untested = []
    features.each do |feature|
      if feature.scenarios_tested
        tested << feature
      else
        untested << feature
      end
    end
    return tested, untested
  end

end
