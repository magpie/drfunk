class PlansController < ApplicationController

  def index
    @plans = Plan.find(:all)
  end

  def show
    @plan = Plan.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        send_data PlanDrawer.draw(@plan), :filename => 'plan.pdf', :type => 'application/pdf', :disposition => 'inline'
      end
    end
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

    @plan.update_attributes(params[:plan])
    render :text => @plan.name
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy

    redirect_to(plans_url)
  end

end
