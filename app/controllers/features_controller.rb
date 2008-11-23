class FeaturesController < ApplicationController

  def create
    @feature = Feature.new(params[:feature])
    @feature.save

    @plan = Plan.find(params[:feature][:plan_id])
  end

  def update
    feature = Feature.find(params[:id])

    feature.update_attributes(params[:feature])
    render :text => feature.name
  end

end