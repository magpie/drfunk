class RequirementsController < ApplicationController
  def edit
    @scenario = Scenario.find(params[:scenario_id])
  end
  
  def update
    @scenario = Scenario.find(params[:scenario_id])
    @scenario.update_attribute(:requirement, params[:scenario][:requirement])
  end

  def show
    @scenario = Scenario.find(params[:scenario_id])
  end
end
