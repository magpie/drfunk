require 'test_helper'

class ResultsControllerTest < ActionController::TestCase
  should_route :put, '/scenarios/1/result', :controller => :results, :action => :update, :scenario_id => 1

  def test_update_ajax
    step = Factory(:step)
    xhr :put, :update, :scenario_id => step.scenario.id, :result => "pass"
    assert_response :success
    assert_select_rjs :chained_replace_html, "sidebar"
  end
end
