class FeaturesController < ApplicationController

  def create
    @feature = Feature.new(params[:feature])
    @feature.save

    @plan = Plan.find(params[:feature][:plan_id])
  end

end
