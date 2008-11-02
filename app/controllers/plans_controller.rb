class PlansController < ApplicationController

  def index
    @plans = Plan.find(:all)
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def new
    @plan = Plan.new
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def create
    @plan = Plan.new(params[:plan])

    if @plan.save 
      flash[:notice] = 'Plan was successfully created.'
      redirect_to(plans_url)
    else
      render :action => "new"
    end
  end

  def update
    @plan = Plan.find(params[:id])

    if @plan.update_attributes(params[:plan])
      flash[:notice] = 'Plan was successfully updated.'
      redirect_to(plans_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy

    redirect_to(plans_url)
  end

end
