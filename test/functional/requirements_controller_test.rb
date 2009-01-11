require 'test_helper'

class RequirementsControllerTest < ActionController::TestCase
  should_route :get, '/scenarios/1/requirement/edit', :controller => :requirements, :action => :edit, :scenario_id => 1
  should_route :get, '/scenarios/1/requirement', :controller => :requirements, :action => :show, :scenario_id => 1
  should_route :put, '/scenarios/1/requirement', :controller => :requirements, :action => :update, :scenario_id => 1

  def test_edit_ajax
    scenario = Factory(:scenario)
    xhr :get, :edit, :scenario_id => scenario.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "requirement"
  end

  def test_update_ajax
    scenario = Factory(:scenario)
    xhr :put, :update, :scenario_id => scenario.id, :scenario => {:requirement => "#ABC 123.4"}
    assert_response :success
    assert_select_rjs :chained_replace_html, "requirement"
  end

  def test_show_ajax
    scenario = Factory(:scenario)
    xhr :get, :show, :scenario_id => scenario.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "requirement"
  end

end
