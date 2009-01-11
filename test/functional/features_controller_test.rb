require 'test_helper'

class FeaturesControllerTest < ActionController::TestCase
  should_route :get, '/features', :controller => :features, :action => :index
  should_route :get, '/features/1/edit', :controller => :features, :action => :edit, :id => 1
  should_route :get, '/features/1', :controller => :features, :action => :show, :id => 1
  should_route :post, '/features', :controller => :features, :action => :create
  should_route :put, '/features/1', :controller => :features, :action => :update, :id => 1
  should_route :delete, '/features/1', :controller => :features, :action => :destroy, :id => 1
  should_route :put, '/features/1/update_scenario_order', :controller => :features, :action => :update_scenario_order, :id => 1

  def test_create_ajax
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :post, :create, :feature => {:name => feature.name, :plan_id => plan.id}
    assert_response :success
    assert_select_rjs :chained_replace_html, "scenario_list"
  end

  def test_show_ajax
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :get, :show, :id => feature.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "feature_#{feature.id}_name"
  end

  def test_edit_ajax
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :get, :edit, :id => feature.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "feature_#{feature.id}_name"
  end

  def test_update_ajax
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :put, :update, :id => feature.id, :feature => { :name => "new feature name" }
    assert_response :success
    assert_select_rjs :chained_replace_html, "feature_#{feature.id}_name"
  end

  def test_destroy_ajax
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :delete, :destroy, :id => feature.id
    assert_response :success
  end

  def test_update_scenario_order_with_no_order_given_ajax
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :put, :update_scenario_order, :id => feature.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "feature_#{feature.id}"
  end

  def test_update_scenario_order_ajax
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    scenario1 = Factory(:scenario, :feature => feature, :plan => plan)
    scenario2 = Factory(:scenario, :feature => feature, :plan => plan)
    feature.reload
    xhr :put, :update_scenario_order, :id => feature.id, "scenario_set_#{feature.id}" => [scenario1.id, scenario2.id]
    assert_response :success
    assert_select_rjs :chained_replace_html, "feature_#{feature.id}"
  end

end
