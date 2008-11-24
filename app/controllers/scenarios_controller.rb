class ScenariosController < ApplicationController

  def show
    @scenario = Scenario.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @scenario = Scenario.new(params[:scenario])
    @scenario.save

    @plan = Plan.find(params[:scenario][:plan_id])
  end

  def edit
    @scenario = Scenario.find(params[:id])
  end

  def update
    @scenario = Scenario.find(params[:id])
    @scenario.update_attribute(:name, params[:scenario][:name])
  end

  def update_feature
    @scenario = Scenario.find(params[:scenario_id])
    @scenario.update_attribute(:feature_id, params[:feature_id])
    @plan = Plan.find(params[:plan_id])
  end

  def update_step_order
    order = params[:sort_step_list]
    order.each_with_index do |id, position|
      Step.find(id).update_attribute(:position, position + 1)
    end

    @scenario = Scenario.find(params[:id])
  end

  def destroy
    @scenario = Scenario.find(params[:id])
    plan = @scenario.plan
    @scenario.destroy

    redirect_to(edit_plan_url(plan))
  end

end
