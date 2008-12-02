class FeaturesController < ApplicationController

  def create
    @plan = Plan.find(params[:feature][:plan_id])
    @plan.features.create(params[:feature])
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
  end

  def destroy
    feature = Feature.find(params[:id])
    feature.scenarios.clear
    feature.destroy

    @plan = Plan.find(params[:plan_id])
  end

end
