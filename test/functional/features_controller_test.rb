require 'test_helper'

class FeaturesControllerTest < ActionController::TestCase
  should_route :get, '/features', :controller => :features, :action => :index
  should_route :get, '/features/1/edit', :controller => :features, :action => :edit, :id => 1
  should_route :get, '/features/1', :controller => :features, :action => :show, :id => 1
  should_route :post, '/features', :controller => :features, :action => :create
  should_route :put, '/features/1', :controller => :features, :action => :update, :id => 1
  should_route :delete, '/features/1', :controller => :features, :action => :destroy, :id => 1
  should_route :put, '/features/1/update_scenario_order', :controller => :features, :action => :update_scenario_order, :id => 1

  context "on POST to :create" do
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    setup { post :create => {:feature => feature}}
    should_assign_to :plan
    should_assign_to :feature
    should_redirect_to "plan_scenarios_url(@plan)"
    should_respond_with :redirect
  end

  context "on DELETE to :destroy" do
    plan = Factory(:plan)
    Factory(:feature, :plan => plan)
    setup { delete :destroy, :id => 1 }
    should_redirect_to "plans_scenarios_url(@plan)"
    should_respond_with :redirect
  end

end
