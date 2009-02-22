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
      format.xml { 
        render :xml => @plan.to_xml( 
          :except => [:id, :plan_id, :feature_id, :scenario_id],
          :include => { :features => { 
            :include => { :scenarios => { 
              :include => :steps } } } } )
      }
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
    @plan = Plan.find(params[:id])
    @scenarios = @plan.search(params[:query])

    respond_to do |format|
      format.html
    end
  end

  def clear_results
    @plan = Plan.find(params[:id])
    @plan.clear_results

    respond_to do |format|
      format.html { redirect_to(plan_scenarios_url(@plan)) }
    end
  end

  def new
    @plan = Plan.new

    respond_to do |format|
      format.html 
    end
  end

  def create_from_xml
    xml_file = params[:plan][:xml]
    Plan.create_from_xml(xml_file)

    respond_to do |format|
      format.html { redirect_to(plans_url) }
    end
  end

  def credits
    respond_to do |format|
      format.html
    end
  end
 
end
