require 'test_helper'

class SetupsControllerTest < ActionController::TestCase
  #should_route :get, '/scenarios/1/setup/edit', :controller => :setups, :action => :edit, :scenario_id => 1
  #should_route :get, '/scenarios/1/setup', :controller => :setups, :action => :show, :scenario_id => 1
  #should_route :put, '/scenarios/1/setup', :controller => :setups, :action => :update, :scenario_id => 1
  test "setup routes" do
    assert_recognizes({:controller => 'setups', :action => 'edit', :scenario_id => '1'}, {:path => 'scenarios/1/setup/edit', :method => :get})
    assert_recognizes({:controller => 'setups', :action => 'show', :scenario_id => '1'}, {:path => 'scenarios/1/setup', :method => :get})
    assert_recognizes({:controller => 'setups', :action => 'update', :scenario_id => '1'}, {:path => 'scenarios/1/setup', :method => :put})
  end

  test "edit ajax" do
    scenario = Factory(:scenario)
    xhr :get, :edit, :scenario_id => scenario.id
    assert_response :success
    assigns(:scenario)
  end

  test "update no setups to copy ajax" do
    scenario = Factory(:scenario)
    xhr :put, :update, :scenario_id => scenario.id, :scenario => {:setup => "do this before you test"}, :other_scenario_id => nil
    assert_response :success
    assigns(:scenario)
  end

  test "update ajax" do
    scenario = Factory(:scenario)
    xhr :put, :update, :scenario_id => scenario.id, :scenario => {:setup => "do this before you test"}, :other_scenario_id => "none_selected"
    assert_response :success
    assigns(:scenario)
  end

  test "update from copy ajax" do
    scenario = Factory(:scenario)
    scenario2 = Factory(:scenario, :setup => "copy this setup")
    xhr :put, :update, :scenario_id => scenario.id, :scenario => {:setup => "this will get overwritten by the copy"}, :other_scenario_id => scenario2.id
    assert_response :success
    assigns(:scenario)
  end

  test "show ajax" do
    scenario = Factory(:scenario)
    xhr :get, :show, :scenario_id => scenario.id
    assert_response :success
    assigns(:scenario)
  end

end
