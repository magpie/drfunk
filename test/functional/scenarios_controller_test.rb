require 'test_helper'

class ScenariosControllerTest < ActionController::TestCase
  should_route :get, '/plans/1/scenarios', :controller => :scenarios, :action => :index, :plan_id => 1
  should_route :get, '/scenarios/1/edit', :controller => :scenarios, :action => :edit, :id => 1
  should_route :get, '/scenarios/1', :controller => :scenarios, :action => :show, :id => 1
  should_route :post, '/plans/1/scenarios', :controller => :scenarios, :action => :create, :plan_id => 1
  should_route :post, '/scenarios/1/duplicate', :controller => :scenarios, :action => :duplicate, :id => 1
  should_route :put, '/scenarios/1', :controller => :scenarios, :action => :update, :id => 1
  should_route :delete, '/scenarios/1', :controller => :scenarios, :action => :destroy, :id => 1
  should_route :put, '/scenarios/1/update_step_order', :controller => :scenarios, :action => :update_step_order, :id => 1

  context "on GET to :index" do
    plan = Factory(:plan)
    scenario = Factory(:scenario, :plan => plan)
    setup { get :index, :plan_id => plan.id}
    should_assign_to :plan
    should_respond_with :success
    should_render_template :index
  end

  def test_show_ajax
    scenario = Factory(:scenario)
    xhr :get, :show, :id => scenario.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "scenario"
  end

  def test_create_ajax
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :post, :create, :plan_id => plan.id, :scenario => {:name => "new scenario name", :feature_id =>  feature.id}
    assert_response :success
    assert_select_rjs :chained_replace_html, "scenario_set_#{feature.id}"
  end

  context "on POST to :duplicate" do
    plan = Factory(:plan)
    scenario = Factory(:scenario, :plan => plan)
    setup { post :duplicate, :id => scenario.id }
    should_assign_to :scenario
    should_redirect_to "scenario_steps_url(@scenario)"
    should_respond_with :redirect
  end

  def test_edit_ajax
    scenario = Factory(:scenario)
    xhr :get, :edit, :id => scenario.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "scenario"
  end

  def test_update_ajax
    scenario = Factory(:scenario)
    xhr :put, :update, :id => scenario.id, :scenario => {:name => "updated scenario name"}
    assert_response :success
    assert_select_rjs :chained_replace_html, "scenario"
  end

  def test_update_step_order_ajax
    scenario = Factory(:scenario)
    step1 = Factory(:step, :scenario => scenario)
    step2 = Factory(:step, :scenario => scenario)
    scenario.reload
    xhr :put, :update_step_order, :id => scenario.id, "step-list" => [step1.id, step2.id]
    assert_response :success
    assert_select_rjs :chained_replace_html, "step-list"
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

  def test_destroy_ajax
    scenario = Factory(:scenario)
    xhr :delete, :destroy, :id => scenario.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "scenario_set_#{scenario.feature.id}"
  end

end
