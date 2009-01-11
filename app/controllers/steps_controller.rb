class StepsController < ApplicationController

  def index
    @scenario = Scenario.find(params[:scenario_id])

    respond_to do |format|
      format.html
    end
  end

  def create
    @scenario = Scenario.find(params[:scenario_id])
    @step = @scenario.steps.create(params[:step])
    @scenario.reload

    respond_to do |format|
      format.js
    end
  end
 
  def show
    @step = Step.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def edit
    @step = Step.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @step = Step.find(params[:id])
    @step.update_attributes(params[:step])

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @step = Step.destroy(params[:id])
    @scenario = Scenario.find(@step.scenario.id)

    respond_to do |format|
      format.js
    end
  end

end
