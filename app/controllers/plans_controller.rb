class PlansController < ApplicationController

  def index
    @plans = Plan.name_sorted

    respond_to do |format|
      format.html
    end
  end

  def edit
    @plan = Plan.find(params[:id])

    respond_to do |format|
      format.js
    end
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
    @plans = Plan.name_sorted

    respond_to do |format|
      format.js
    end
  end

  def update
    @plan = Plan.find(params[:id])
    @plan.update_attribute(:name, params[:plan][:name])

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @plan = Plan.destroy(params[:id])

    respond_to do |format|
      format.html { redirect_to(plans_url) }
      format.js
    end
  end

  def search
    @query = params[:query]
    if params[:id]
      @plan = Plan.find(params[:id])
      render :action => :search
    else
      @plans = Plan.find(:all)
      render :action => :search_all
    end 
  end
 
end
