class StepsController < ApplicationController

  def index
    @scenario = Scenario.find(params[:scenario_id])
  end

  def create
    @scenario = Scenario.find(params[:scenario_id])
    @step = @scenario.steps.create(params[:step])
    @scenario.reload
  end
 
  def show
    @step = Step.find(params[:id])
  end

  def edit
    @step = Step.find(params[:id])
  end

  def update
    @step = Step.find(params[:id])
    @step.update_attributes(params[:step])
  end

  def destroy
    @step = Step.destroy(params[:id])
    @scenario = Scenario.find(@step.scenario.id)
  end

end
