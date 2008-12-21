class SetupsController < ApplicationController
  
  def edit
    @scenario = Scenario.find(params[:scenario_id])
  end
  
  def update
    @scenario = Scenario.find(params[:scenario_id])
    if params[:other_scenario_id] == "place_holder"
      @scenario.update_attribute(:setup, params[:scenario][:setup])
    else
      other_scenario = Scenario.find(params[:other_scenario_id])
      @scenario.update_attribute(:setup, other_scenario.setup)
    end
  end

  def show
    @scenario = Scenario.find(params[:scenario_id])
  end

end
