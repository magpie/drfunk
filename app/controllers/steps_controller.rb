class StepsController < ApplicationController

  def index
    @scenario = Scenario.find(params[:scenario_id])
  end

  def create
    @step = Step.new(params[:step])
    @scenario  = Scenario.find(params[:scenario_id])
    @step.scenario_id = @scenario.id
    @step.position = @scenario.steps.length + 1
    @step.save

    @scenario.reload
  end
 
  def show
    @step = Step.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @step = Step.find(params[:id])
  end

  def update
    @step = Step.find(params[:id])
    @step.update_attributes(params[:step])
  end

  def destroy
    @step = Step.find(params[:id])
    @scenario  = Scenario.find(@step.scenario_id)
    @scenario.update_positions_for_delete(@step.position)
    @step.destroy

    @scenario.reload
  end

end
