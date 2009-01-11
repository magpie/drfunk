class RequirementsController < ApplicationController
  def edit
    @scenario = Scenario.find(params[:scenario_id])

    respond_to do |format|
      format.js
    end
  end
  
  def update
    @scenario = Scenario.find(params[:scenario_id])
    @scenario.update_attribute(:requirement, params[:scenario][:requirement])

    respond_to do |format|
      format.js
    end
  end

  def show
    @scenario = Scenario.find(params[:scenario_id])

    respond_to do |format|
      format.js
    end
  end
end
