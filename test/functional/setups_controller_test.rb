require 'test_helper'

class SetupsControllerTest < ActionController::TestCase
  should_route :get, '/scenarios/1/setup/edit', :controller => :setups, :action => :edit, :scenario_id => 1
  should_route :get, '/scenarios/1/setup', :controller => :setups, :action => :show, :scenario_id => 1
  should_route :put, '/scenarios/1/setup', :controller => :setups, :action => :update, :scenario_id => 1

  def test_edit_ajax
    scenario = Factory(:scenario)
    xhr :get, :edit, :scenario_id => scenario.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "setup"
  end

  def test_update_no_setups_to_copy_ajax
    scenario = Factory(:scenario)
    xhr :put, :update, :scenario_id => scenario.id, :scenario => {:setup => "do this before you test"}, :other_scenario_id => nil
    assert_response :success
    assert_select_rjs :chained_replace_html, "setup"
  end

  def test_update_ajax
    scenario = Factory(:scenario)
    xhr :put, :update, :scenario_id => scenario.id, :scenario => {:setup => "do this before you test"}, :other_scenario_id => "none_selected"
    assert_response :success
    assert_select_rjs :chained_replace_html, "setup"
  end

  def test_update_from_copy_ajax
    scenario = Factory(:scenario)
    scenario2 = Factory(:scenario, :setup => "copy this setup")
    xhr :put, :update, :scenario_id => scenario.id, :scenario => {:setup => "this will get overwritten by the copy"}, :other_scenario_id => scenario2.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "setup"
  end

  def test_show_ajax
    scenario = Factory(:scenario)
    xhr :get, :show, :scenario_id => scenario.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "setup"
  end

end
