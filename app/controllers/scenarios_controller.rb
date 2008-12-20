class ScenariosController < ApplicationController

  def index
    @plan = Plan.find(params[:plan_id])
  end

  def show
    @scenario = Scenario.find(params[:id])
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @scenario = @plan.scenarios.create(params[:scenario])
    @feature = @scenario.feature.reload
  end

  def edit
    @scenario = Scenario.find(params[:id])
  end

  def update
    @scenario = Scenario.find(params[:id])
    @scenario.update_attributes(params[:scenario])
  end

  def update_step_order
    order = params[:step_list]
    order.each_with_index do |id, position|
      Step.find(id).update_attribute(:position, position + 1)
    end

    @scenario = Scenario.find(params[:id])
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
