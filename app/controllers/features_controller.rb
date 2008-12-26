class FeaturesController < ApplicationController

  def create
    @plan = Plan.find(params[:feature][:plan_id])
    @feature = @plan.features.create(params[:feature])

    respond_to do |format|
      format.html { redirect_to(plan_scenarios_url(@plan)) }
      format.js
    end
  end

  def show
    @feature = Feature.find(params[:id])
  end

  def edit
    @feature = Feature.find(params[:id])
  end

  def update
    @feature = Feature.find(params[:id])
    @feature.update_attribute(:name, params[:feature][:name])
    @plan = @feature.plan
  end

  def destroy
    @feature = Feature.destroy(params[:id])
    @plan = Plan.find(params[:plan_id])

    respond_to do |format|
      format.html { redirect_to(plan_scenarios_url(@plan)) }
      format.js
    end
  end

  def update_scenario_order
    @feature = Feature.find(params[:id])
    @feature.scenarios.clear

    order = params["scenario_set_#{@feature.id}"]
    unless order.nil?
      order.each_with_index do |id, position|
        scenario = Scenario.find(id)
        scenario.update_attribute(:position, position + 1)
        @feature.scenarios << scenario
      end
    end
  end

end
