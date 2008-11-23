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
    @scenario = Scenario.find(params[:id])

    if params[:name]
      @scenario.update_attribute(:name, params[:name])
      render :text => @scenario.name
    end
  end

  def update_feature
    @scenario = Scenario.find(params[:scenario_id])
    @scenario.update_attribute(:feature_id, params[:feature_id])
    @plan = Plan.find(params[:plan_id])
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
