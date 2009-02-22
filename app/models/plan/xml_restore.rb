class Plan
  module XmlRestore
  
    def self.create(xml)
      xml = Hash.from_xml(xml)['plan']
      plan = Plan.new
      plan.name =  xml['name'] + " (from xml)"
      plan.save

      xml['features'].each do |feature_xml|
        feature = Feature.new
        feature.plan_id = plan.id
        feature.name = feature_xml['name']
        feature.save

        feature_xml['scenarios'].each do |scenario_xml|
          scenario = Scenario.new
          scenario.plan_id = plan.id
          scenario.feature_id = feature.id
          scenario.name = scenario_xml['name']
          scenario.setup = scenario_xml['setup']
          scenario.requirement = scenario_xml['requirement']
          scenario.result = scenario_xml['result']
          scenario.position = scenario_xml['position']
          scenario.save

          scenario_xml['steps'].each do |step_xml|
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
