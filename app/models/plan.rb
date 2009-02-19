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

  def clear_results
    scenarios.update_all("result = 'NULL'")
  end

  def search query
    matches = []
    if query.nil? || query.empty?
      return matches
    end 

    query = query.downcase

    scenarios.each do |scenario| 
      if scenario.search(query)
        matches << scenario
      end
    end

    matches
  end

  def self.create_from_xml(xml)
    Plan.transaction do

    xml = Hash.from_xml(xml)['plan']
    plan = Plan.new
    plan.name =  xml['name'] + " (from xml)"
    plan.save
    for feature_xml in xml['features']
      feature = Feature.new
      feature.plan_id = plan.id
      feature.name = feature_xml['name']
      feature.save
      for scenario_xml in feature_xml['scenarios']
        scenario = Scenario.new
        scenario.plan_id = plan.id
        scenario.feature_id = feature.id
        scenario.name = scenario_xml['name']
        scenario.setup = scenario_xml['setup']
        scenario.requirement = scenario_xml['requirement']
        scenario.result = scenario_xml['result']
        scenario.position = scenario_xml['position']
        scenario.save

        for step_xml in scenario_xml['steps']
          step = Step.new
          step.scenario_id = scenario.id
          step.description = step_xml['description']
          step.expected = step_xml['expected']
          step.position = step_xml['position']
          step.save
        end

        # Wait until steps are made to reset timestamp
        scenario.updated_at = scenario_xml['updated_at']
        scenario.save
      end
    end

    end
  end

end
