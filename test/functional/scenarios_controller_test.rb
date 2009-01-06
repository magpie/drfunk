require 'test_helper'

class ScenariosControllerTest < ActionController::TestCase
  should_route :get, '/plans/1/scenarios', :controller => :scenarios, :action => :index, :plan_id => 1
  should_route :get, '/scenarios/1/edit', :controller => :scenarios, :action => :edit, :id => 1
  should_route :get, '/scenarios/1', :controller => :scenarios, :action => :show, :id => 1
  should_route :post, '/plans/1/scenarios', :controller => :scenarios, :action => :create, :plan_id => 1
  should_route :post, '/scenarios/1/duplicate', :controller => :scenarios, :action => :duplicate, :id => 1
  should_route :put, '/scenarios/1', :controller => :scenarios, :action => :update, :id => 1
  should_route :delete, '/scenarios/1', :controller => :scenarios, :action => :destroy, :id => 1

  context "on GET to :index" do
    plan = Factory(:plan)
    scenario = Factory(:scenario, :plan => plan)
    setup { get :index, :scenario => {:name => scenario.name}, :plan_id => plan.id}
    should_assign_to :plan
    should_respond_with :success
    should_render_template :index
  end

  context "on GET to :index with query" do
    plan = Factory(:plan)
    scenario = Factory(:scenario, :plan => plan)
    setup { get :index, :scenario => {:name => scenario.name}, :plan_id => plan.id, :query => "abc"}
    should_assign_to :plan
    should_assign_to :query
    should_respond_with :success
    should_render_template :index
  end

  context "on DELETE to :destroy" do
    plan = Factory(:plan)
    scenario = Factory(:scenario, :plan => plan)
    setup { delete :destroy, :id => scenario.id }
    should_assign_to :scenario
    should_assign_to :feature
    should_redirect_to "plan_scenarios_url(@scenario.plan.id)"
    should_respond_with :redirect
  end

  context "on POST to :duplicate" do
    plan = Factory(:plan)
    scenario = Factory(:scenario, :plan => plan)
    setup { post :duplicate, :id => scenario.id }
    should_assign_to :scenario
    should_redirect_to "scenario_steps_url(@scenario)"
    should_respond_with :redirect
  end

end
