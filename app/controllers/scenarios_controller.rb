class ScenariosController < ApplicationController

  def show
    @scenario = Scenario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @scenario }
    end
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

  def destroy
    @scenario = Scenario.find(params[:id])
    @scenario.destroy

    respond_to do |format|
      format.html { redirect_to(scenarios_url) }
      format.xml  { head :ok }
    end
  end

end
