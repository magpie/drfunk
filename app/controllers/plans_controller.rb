class PlansController < ApplicationController

  def index
    @plans = Plan.name_sorted
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
    @plan = Plan.create(params[:plan])
    @plans = Plan.find(:all)

    respond_to do |format|
      format.html { redirect_to(plans_url) }
      format.js
    end
  end

  def update
    @plan = Plan.find(params[:id])
    @plan.update_attribute(:name, params[:plan][:name])
  end

  def destroy
    @plan = Plan.destroy(params[:id])

    respond_to do |format|
      format.html { redirect_to(plans_url) }
      format.js
    end
  end

end
