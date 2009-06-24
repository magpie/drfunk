class ScenariosController < ApplicationController

  def index
    @plan = Plan.find(params[:plan_id])

    respond_to do |format|
      format.html
    end
  end

  def show
    @scenario = Scenario.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @scenario = @plan.scenarios.create(params[:scenario])
    @feature = @scenario.feature.reload

    respond_to do |format|
      format.js
    end
  end

  def duplicate
    @scenario = Scenario.find(params[:id]).duplicate
    
    respond_to do |format|
      format.html { redirect_to(scenario_steps_url(@scenario)) }
    end
  end

  def edit
    @scenario = Scenario.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @scenario = Scenario.find(params[:id])
    @scenario.update_attributes(params[:scenario])

    respond_to do |format|
      format.js
    end
  end

  def update_step_order
    order = params["step-list"]
    order.each_with_index do |id, new_position|
      Step.find(id).update_attribute(:position, new_position + 1)
    end

    @scenario = Scenario.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @scenario = Scenario.destroy(params[:id])
    @feature = @scenario.feature

    respond_to do |format|
      format.html { redirect_to(plan_scenarios_url(@scenario.plan.id)) }
      format.js
    end
  end

end

