class SetupsController < ApplicationController
  
  def create
    @scenario = Scenario.find(params[:scenario_id])
    setup = Setup.create(params[:setup])
    @scenario.setup = setup
    @scenario.save
  end

  def copy
    @scenario = Scenario.find(params[:scenario_id])
    other_setup = Scenario.find(params[:other_scenario_id]).setup
    setup = Setup.create(:content => other_setup.content)
    @scenario.setup = setup
    @scenario.save
  end

  def edit
    @scenario = Scenario.find(params[:scenario_id])
  end
  
  def update
    @scenario = Scenario.find(params[:scenario_id])
    @scenario.setup.content = params[:setup][:content]
    @scenario.setup.save
  end

  def show
    @scenario = Scenario.find(params[:scenario_id])
  end

  def destroy
    @scenario = Scenario.find(params[:scenario_id])
    @scenario.setup.destroy
  end

end
