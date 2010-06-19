class FeaturesController < ApplicationController

  def create
    @plan = Plan.find(params[:feature][:plan_id])
    @feature = @plan.features.create(params[:feature])

    respond_to do |format|
      format.js
    end
  end

  def show
    @feature = Feature.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def edit
    @feature = Feature.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @feature = Feature.find(params[:id])
    @feature.update_attribute(:name, params[:feature][:name])
    @plan = @feature.plan

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @feature = Feature.destroy(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update_scenario_order
    @feature = Feature.find(params[:id])
    @feature.scenarios.clear

    order = params[:scenario]
    if order
      order.each_with_index do |id, new_position|
        scenario = Scenario.find(id)
        scenario.update_attribute(:position, new_position + 1)
        @feature.scenarios << scenario
      end
    end
  end

end

