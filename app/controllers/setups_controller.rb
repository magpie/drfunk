class SetupsController < ApplicationController

  def edit
    @scenario = Scenario.find(params[:scenario_id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @scenario = Scenario.find(params[:scenario_id])

    if params[:other_scenario_id].nil? || params[:other_scenario_id] == "none_selected"
      new_setup = params[:scenario][:setup]
    else
      new_setup = Scenario.find(params[:other_scenario_id]).setup
    end
    @scenario.update_attribute(:setup, new_setup)

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

