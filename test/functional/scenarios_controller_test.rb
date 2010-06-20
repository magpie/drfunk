require 'test_helper'

class ScenariosControllerTest < ActionController::TestCase
  test "scenario routes" do
    assert_recognizes({:controller => 'scenarios', :action => 'index', :plan_id => '1'}, {:path => 'plans/1/scenarios', :method => :get})
    assert_recognizes({:controller => 'scenarios', :action => 'edit', :id => '1'}, {:path => 'scenarios/1/edit', :method => :get})
    assert_recognizes({:controller => 'scenarios', :action => 'show', :id => '1'}, {:path => 'scenarios/1', :method => :get})
    assert_recognizes({:controller => 'scenarios', :action => 'create', :plan_id => '1'}, {:path => 'plans/1/scenarios', :method => :post})
    assert_recognizes({:controller => 'scenarios', :action => 'duplicate', :id => '1'}, {:path => 'scenarios/1/duplicate', :method => :post})
    assert_recognizes({:controller => 'scenarios', :action => 'update', :id => '1'}, {:path => 'scenarios/1', :method => :put})
    assert_recognizes({:controller => 'scenarios', :action => 'destroy', :id => '1'}, {:path => 'scenarios/1', :method => :delete})
    assert_recognizes({:controller => 'scenarios', :action => 'update_step_order', :id => '1'}, {:path => 'scenarios/1/update_step_order', :method => :put})
  end

  test "get index" do
    plan = Factory(:plan)
    scenario = Factory(:scenario, :plan => plan)
    get :index, :plan_id => plan.id
    assert_not_nil assigns(:plan)
    assert_response :success
    assert_template :index
  end

  test "show ajax" do
    scenario = Factory(:scenario)
    xhr :get, :show, :id => scenario.id
    assert_response :success
    assert assigns(:scenario)
  end

  test "create ajax" do
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :post, :create, :plan_id => plan.id, :scenario => {:name => "new scenario name", :feature_id =>  feature.id}
    assert_response :success
    assert assigns(:plan)
    assert assigns(:scenario)
    assert assigns(:feature)
  end

  test "post to duplicate" do
    plan = Factory(:plan)
    scenario = Factory(:scenario, :plan => plan)
    post :duplicate, :id => scenario.id
    assert_not_nil assigns(:scenario)
    assert_response :redirect
    assert_redirected_to scenario_steps_url(scenario.id + 1)
  end

  test "edit ajax" do
    scenario = Factory(:scenario)
    xhr :get, :edit, :id => scenario.id
    assert_response :success
    assert assigns(:scenario)
  end

  test "update ajax" do
    scenario = Factory(:scenario)
    xhr :put, :update, :id => scenario.id, :scenario => {:name => "updated scenario name"}
    assert_response :success
    result = assigns(:scenario)
    assert result
    assert_equal "updated scenario name", result.name
  end

  test "update step order ajax" do
    scenario = Factory(:scenario)
    step1 = Factory(:step, :scenario => scenario)
    step2 = Factory(:step, :scenario => scenario)
    scenario.reload
    xhr :put, :update_step_order, :id => scenario.id, "step" => [step1.id, step2.id]
    assert_response :success
    assert assigns(:scenario)
  end

  test "delete to destroy" do
    plan = Factory(:plan)
    scenario = Factory(:scenario, :plan => plan)
    delete :destroy, :id => scenario.id
    assert_not_nil assigns(:scenario)
    assert_not_nil assigns(:feature)
    assert_response :redirect
    assert_redirected_to plan_scenarios_url(scenario.plan.id, :anchor => "feature_#{scenario.feature.id}")
  end

  test "destroy_ajax" do
    scenario = Factory(:scenario)
    xhr :delete, :destroy, :id => scenario.id
    assert_response :success
    assert assigns(:scenario)
    assert assigns(:feature)
  end

end
