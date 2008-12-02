class FeaturesController < ApplicationController

  def create
    @feature = Feature.new(params[:feature])
    @feature.save

    @plan = Plan.find(params[:feature][:plan_id])
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
