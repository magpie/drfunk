require 'test_helper'

class ResultsControllerTest < ActionController::TestCase

  test "result routes" do
    assert_recognizes({:controller => 'results', :action => 'update', :scenario_id => '1'}, {:path => 'scenarios/1/result', :method => :put})
  end

  test "update ajax" do
    step = Factory(:step)
    xhr :put, :update, :scenario_id => step.scenario.id, :result => "pass"
    assert_response :success
    assigns(:scenario)
  end
end
