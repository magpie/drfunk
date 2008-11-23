class FeaturesController < ApplicationController

  def create
    @feature = Feature.new(params[:feature])
    @feature.save

    @plan = Plan.find(params[:feature][:plan_id])
  end

  def update
    feature = Feature.find(params[:id])

    if params[:name]
      feature.update_attribute(:name, params[:name])
      render :text => feature.name
    end
  end

end
