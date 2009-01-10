require 'test_helper'

class PlansControllerTest < ActionController::TestCase
  should_route :get, '/plans', :controller => :plans, :action => :index
  should_route :get, '/plans/1/edit', :controller => :plans, :action => :edit, :id => 1
  should_route :get, '/plans/1', :controller => :plans, :action => :show, :id => 1
  should_route :post, '/plans', :controller => :plans, :action => :create
  should_route :put, '/plans/1', :controller => :plans, :action => :update, :id => 1
  should_route :delete, '/plans/1', :controller => :plans, :action => :destroy, :id => 1
  should_route :get, '/plans/search', :controller => :plans, :action => :search
  should_route :get, '/plans/search/1', :controller => :plans, :action => :search, :id => 1

  context "on GET to :search one plan" do
    step = Factory(:step)
    setup { get :search, :id => step.scenario.plan.id, :query => "abc" }
    should_assign_to :query
    should_assign_to :plan
    should_respond_with :success
    should_render_template :search
  end

  context "on GET to :search all plans" do
    5.times { Factory(:step) }
    setup { get :search, :query => "abc" }
    should_assign_to :query
    should_assign_to :plans
    should_respond_with :success
    should_render_template :search_all
  end

  context "on GET to :index" do
    5.times { Factory(:step) }
    setup { get :index }
    should_assign_to :plans
    should_respond_with :success
    should_render_template :index
  end

  context "on GET to :show" do
    step = Factory(:step)
    setup { get :show, :id => step.scenario.plan.id }
    should_assign_to :plan
    should_respond_with :success
    should_render_template :show
  end

  def test_show_ajax
    step = Factory(:step)
    xhr :get, :show, :id => step.scenario.plan.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "plan"
  end

  context "on DELETE to :destroy" do
    step = Factory(:step)
    setup { delete :destroy, :id => step.scenario.plan.id }
    should_redirect_to "plans_url"
    should_respond_with :redirect
  end

  def test_destroy_ajax
    step = Factory(:step)
    xhr :delete, :destroy, :id => step.scenario.plan.id
    assert_response :success
  end

  def test_edit_ajax
    step = Factory(:step)
    xhr :get, :edit, :id => step.scenario.plan.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "plan"
  end

  def test_update_ajax
    step = Factory(:step)
    xhr :put, :update, :id => step.scenario.plan.id, :plan => {:name => "new name"}
    assert_response :success
    assert_select_rjs :chained_replace_html, "plan"
  end

  def test_create_ajax
    step = Factory(:step)
    xhr :post, :create, :id => step.scenario.plan.id, :plan => {:name => "new plan"}
    assert_response :success
    assert_select_rjs :chained_replace_html, "plan_list"
  end

end
