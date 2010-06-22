require 'test_helper'

class RequirementsControllerTest < ActionController::TestCase

  test "requirement routes" do
    assert_recognizes({:controller => 'requirements', :action => 'edit', :scenario_id => '1'}, {:path => 'scenarios/1/requirement/edit', :method => :get})
    assert_recognizes({:controller => 'requirements', :action => 'show', :scenario_id => '1'}, {:path => 'scenarios/1/requirement', :method => :get})
    assert_recognizes({:controller => 'requirements', :action => 'update', :scenario_id => '1'}, {:path => 'scenarios/1/requirement', :method => :put})
  end

  test "edit ajax" do
    scenario = Factory(:scenario)
    xhr :get, :edit, :scenario_id => scenario.id
    assert_response :success
    assert assigns(:scenario)
  end

  test "update ajax" do
    scenario = Factory(:scenario)
    xhr :put, :update, :scenario_id => scenario.id, :scenario => {:requirement => "#ABC 123.4"}
    assert_response :success
    assert assigns(:scenario)
  end

  test "show ajax" do
    scenario = Factory(:scenario)
    xhr :get, :show, :scenario_id => scenario.id
    assert_response :success
    assert assigns(:scenario)
  end

end
