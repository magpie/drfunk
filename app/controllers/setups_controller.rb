class SetupsController < ApplicationController
  
  def create
    @scenario = Scenario.find(params[:scenario_id])
    @scenario.update_attribute(:setup, params[:scenario][:setup])
  end

  def copy
    @scenario = Scenario.find(params[:scenario_id])
    other_setup = Scenario.find(params[:other_scenario_id]).setup
    @scenario.update_attribute(:setup, other_setup)
  end

  def edit
    @scenario = Scenario.find(params[:scenario_id])
  end
  
  def update
    @scenario = Scenario.find(params[:scenario_id])
    @scenario.update_attribute(:setup, params[:scenario][:setup])
  end

  def show
    @scenario = Scenario.find(params[:scenario_id])
  end

  def destroy
    @scenario = Scenario.find(params[:scenario_id])
    @scenario.update_attribute(:setup, nil)
  end

end
