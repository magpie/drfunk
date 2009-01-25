xml.plan do
  xml.name @plan.name
  xml.features do
    for feature in @plan.features
      xml.feature do
	 xml.name(feature.name)
         xml.scenarios do
           for scenario in feature.scenarios
             xml.scenario do
               xml.name scenario.name
               xml.setup scenario.setup
               xml.requirement scenario.requirement
               xml.result scenario.result
               xml.position scenario.position
               xml.steps do
                 for step in scenario.steps
                   xml.step do
                     xml.position step.position
                     xml.description step.description
                     xml.expected step.expected
                   end 
                 end
               end
             end
           end
         end
      end
    end
  end
end

