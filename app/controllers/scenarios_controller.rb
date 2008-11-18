class ScenariosController < ApplicationController

  # GET /scenarios
  # GET /scenarios.xml
  def index
    @scenarios = Scenario.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scenarios }
    end
  end

  # GET /scenarios/1
  # GET /scenarios/1.xml
  def show
    @scenario = Scenario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @scenario }
    end
  end

  # GET /scenarios/new
  # GET /scenarios/new.xml
  def new
    @plans = Plan.find(:all)
    @scenario = Scenario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @scenario }
    end
  end

  # GET /scenarios/1/edit
  def edit
    @plans = Plan.find(:all)
    @scenario = Scenario.find(params[:id])
  end

  def create
    @scenario = Scenario.new(params[:scenario])
    @scenario.save

    @plan = Plan.find(params[:scenario][:plan_id])
  end

  def update
    @scenario = Scenario.find(params[:scenario])
    @scenario.feature_id = params[:feature_id]
    @scenario.save

    @plan = Plan.find(params[:plan_id])
    #@scenario.update_attributes(params[:scenario])

    #redirect_to(@scenario)
  end

  def update_step_order
    order = params[:sort_step_list]
    order.each_with_index do |id, position|
      Step.find(id).update_attribute(:position, position + 1)
    end

    @scenario = Scenario.find(params[:id])
  end

  # DELETE /scenarios/1
  # DELETE /scenarios/1.xml
  def destroy
    @scenario = Scenario.find(params[:id])
    @scenario.destroy

    respond_to do |format|
      format.html { redirect_to(scenarios_url) }
      format.xml  { head :ok }
    end
  end

end
