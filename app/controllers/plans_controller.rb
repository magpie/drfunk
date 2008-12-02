class PlansController < ApplicationController

  def index
    @plans = Plan.find(:all)
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def show
    @plan = Plan.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    Plan.create(params[:plan])
    @plans = Plan.find(:all)
  end

  def update
    @plan = Plan.find(params[:id])
    @plan.update_attribute(:name, params[:plan][:name])
  end

  def destroy
    Plan.destroy(params[:id])
    redirect_to(plans_url)
  end

end
