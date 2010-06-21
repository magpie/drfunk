require 'test_helper'

class StepsControllerTest < ActionController::TestCase

  test "step routes" do
    assert_recognizes({:controller => 'steps', :action => 'index', :scenario_id => '1'}, {:path => 'scenarios/1/steps', :method => :get})
    assert_recognizes({:controller => 'steps', :action => 'edit', :id => '1'}, {:path => 'steps/1/edit', :method => :get})
    assert_recognizes({:controller => 'steps', :action => 'show', :id => '1'}, {:path => 'steps/1', :method => :get})
    assert_recognizes({:controller => 'steps', :action => 'create', :scenario_id => '1'}, {:path => 'scenarios/1/steps', :method => :post})
    assert_recognizes({:controller => 'steps', :action => 'update', :id => '1'}, {:path => 'steps/1', :method => :put})
    assert_recognizes({:controller => 'steps', :action => 'destroy', :id => '1'}, {:path => 'steps/1', :method => :delete})
  end

  test "get index" do
    scenario = Factory(:scenario)
    step1 = Factory(:step, :scenario => scenario)
    step2 = Factory(:step, :scenario => scenario)
    step3 = Factory(:step, :scenario => scenario)
    get :index, :scenario_id => scenario.id
    assert_not_nil assigns(:scenario)
    assert_response :success
    assert_template :index
  end

  test "create ajax" do
    scenario = Factory(:scenario)
    xhr :post, :create, :scenario_id => scenario.id, :step => {:description => "do this", :expected => "expect this"}
    assert_response :success
    assert assigns(:scenario)
    assert assigns(:step)
  end

  test "show_ajax" do
    step = Factory(:step)
    xhr :get, :show, :id => step.id
    assert_response :success
    assert assigns(:step)
  end

  test "edit ajax" do
    step = Factory(:step)
    xhr :get, :edit, :id => step.id
    assert_response :success
    assert assigns(:step)
  end

  test "update ajax" do
    step = Factory(:step)
    xhr :put, :update, :id => step.id, :step => {:description => "new do this", :expected => "new expect this"}
    assert_response :success
    assert assigns(:step)
  end

  test "destroy ajax" do
    step = Factory(:step)
    xhr :delete, :destroy, :id => step.id
    assert_response :success
    assert assigns(:scenario)
    assert assigns(:step)
  end

  test "get pdf" do
    scenario = Factory(:scenario)
    step1 = Factory(:step, :scenario => scenario)
    step2 = Factory(:step, :scenario => scenario)
    step3 = Factory(:step, :scenario => scenario)
    get :index, :scenario_id => scenario.id, :format => :pdf
    result_scenario = assigns(:scenario)
    assert_equal result_scenario, scenario
    assert_response :success
  end

end
