require 'test_helper'

class FeaturesControllerTest < ActionController::TestCase

  test "feature routes" do
    assert_recognizes({:controller => 'features', :action => 'index'}, {:path => 'features', :method => :get})
    assert_recognizes({:controller => 'features', :action => 'edit', :id => '1'}, {:path => 'features/1/edit', :method => :get})
    assert_recognizes({:controller => 'features', :action => 'show', :id => '1'}, {:path => 'features/1', :method => :get})
    assert_recognizes({:controller => 'features', :action => 'create'}, {:path => 'features', :method => :post})
    assert_recognizes({:controller => 'features', :action => 'update', :id => '1'}, {:path => 'features/1', :method => :put})
    assert_recognizes({:controller => 'features', :action => 'destroy', :id => '1'}, {:path => 'features/1', :method => :delete})
    assert_recognizes({:controller => 'features', :action => 'update_scenario_order', :id => '1'}, {:path => 'features/1/update_scenario_order', :method => :put})
  end

  test "create ajax" do
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :post, :create, :feature => {:name => feature.name, :plan_id => plan.id}
    assert_response :success
    assert_select_rjs :chained_replace_html, "scenario_list"
  end

  test "show ajax" do
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :get, :show, :id => feature.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "feature_#{feature.id}_name"
  end

  test "edit ajax" do
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :get, :edit, :id => feature.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "feature_#{feature.id}_name"
  end

  test "update ajax" do
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :put, :update, :id => feature.id, :feature => { :name => "new feature name" }
    assert_response :success
    assert_select_rjs :chained_replace_html, "feature_#{feature.id}_name"
  end

  test "destroy ajax" do
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :delete, :destroy, :id => feature.id
    assert_response :success
  end

  test "update scenario order with no order given ajax" do
    plan = Factory(:plan)
    feature = Factory(:feature, :plan => plan)
    xhr :put, :update_scenario_order, :id => feature.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "feature_#{feature.id}"
  end

  test "update scenario order ajax" do
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
