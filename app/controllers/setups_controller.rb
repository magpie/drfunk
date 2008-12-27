class SetupsController < ApplicationController
  
  def edit
    @scenario = Scenario.find(params[:scenario_id])
  end
  
  def update
    @scenario = Scenario.find(params[:scenario_id])

    if params[:other_scenario_id].nil? || params[:other_scenario_id] == "none_selected"
      @scenario.update_attribute(:setup, params[:scenario][:setup])
    else
      @scenario.copy_setup(params[:other_scenario_id])
    end
  end

  def show
    @scenario = Scenario.find(params[:scenario_id])
  end

end
