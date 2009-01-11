require 'test_helper'

class StepsControllerTest < ActionController::TestCase
  should_route :get, '/scenarios/1/steps', :controller => :steps, :action => :index, :scenario_id => 1
  should_route :get, '/steps/1/edit', :controller => :steps, :action => :edit, :id => 1
  should_route :get, '/steps/1', :controller => :steps, :action => :show, :id => 1
  should_route :post, '/scenarios/1/steps', :controller => :steps, :action => :create, :scenario_id => 1
  should_route :put, '/steps/1', :controller => :steps, :action => :update, :id => 1
  should_route :delete, '/steps/1', :controller => :steps, :action => :destroy, :id => 1

  context "on GET to :index" do
    scenario = Factory(:scenario)
    step1 = Factory(:step, :scenario => scenario)
    step2 = Factory(:step, :scenario => scenario)
    step3 = Factory(:step, :scenario => scenario)
    setup { get :index, :scenario_id => scenario.id}
    should_assign_to :scenario
    should_respond_with :success
    should_render_template :index
  end

  def test_create_ajax
    scenario = Factory(:scenario)
    xhr :post, :create, :scenario_id => scenario.id, :step => {:description => "do this", :expected => "expect this"}
    assert_response :success
    assert_select_rjs :chained_replace_html, "step_list"
  end

  def test_show_ajax
    step = Factory(:step)
    xhr :get, :show, :id => step.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "step_#{step.id}"
  end

  def test_edit_ajax
    step = Factory(:step)
    xhr :get, :edit, :id => step.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "step_#{step.id}"
  end

  def test_update_ajax
    step = Factory(:step)
    xhr :put, :update, :id => step.id, :step => {:description => "new do this", :expected => "new expect this"}
    assert_response :success
    assert_select_rjs :chained_replace_html, "step_#{step.id}"
  end

  def test_destroy_ajax
    step = Factory(:step)
    xhr :delete, :destroy, :id => step.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "step_list"
  end

end
