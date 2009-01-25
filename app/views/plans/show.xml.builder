xml.plan do
  xml.name @plan.name
  xml.created_at @plan.created_at
  xml.updated_at @plan.updated_at
  xml.features do
    for feature in @plan.features
      xml.feature do
	 xml.name feature.name
	 xml.created_at feature.created_at
	 xml.updated_at feature.updated_at
         xml.scenarios do
           for scenario in feature.scenarios
             xml.scenario do
               xml.name scenario.name
               xml.setup scenario.setup
               xml.requirement scenario.requirement
               xml.result scenario.result
               xml.position scenario.position
	       xml.created_at scenario.created_at
	       xml.updated_at scenario.updated_at
               xml.steps do
                 for step in scenario.steps
                   xml.step do
                     xml.position step.position
                     xml.description step.description
                     xml.expected step.expected
	             xml.created_at step.created_at
	             xml.updated_at step.updated_at
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

