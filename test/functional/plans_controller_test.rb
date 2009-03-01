require 'test_helper'

class PlansControllerTest < ActionController::TestCase
  should_route :get, '/plans', :controller => :plans, :action => :index
  should_route :get, '/plans/1/edit', :controller => :plans, :action => :edit, :id => 1
  should_route :get, '/plans/1', :controller => :plans, :action => :show, :id => 1
  should_route :post, '/plans', :controller => :plans, :action => :create
  should_route :put, '/plans/1', :controller => :plans, :action => :update, :id => 1
  should_route :delete, '/plans/1', :controller => :plans, :action => :destroy, :id => 1
  should_route :get, '/plans/1/search', :controller => :plans, :action => :search, :id => 1
  should_route :put, '/plans/1/clear_results', :controller => :plans, :action => :clear_results, :id => 1
  should_route :post, '/plans/create_from_xml', :controller => :plans, :action => :create_from_xml
  should_route :get, '/plans/new', :controller => :plans, :action => :new
  should_route :get, '/credits', :controller => :plans, :action => :credits

  context "on GET to :new" do
    setup { get :new }
    should_assign_to :plan
    should_respond_with :success
    should_render_template :new
  end

  context "on GET to :credits" do
    setup { get :credits }
    should_respond_with :success
    should_render_template :credits
  end

  context "on GET to :search" do
    step = Factory(:step)
    setup { get :search, :id => step.scenario.plan.id, :query => "abc" }
    should_assign_to :plan
    should_assign_to :scenarios
    should_respond_with :success
    should_render_template :search
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

  context "on POST to :create_from_xml bad" do
    step = Factory(:step)
    setup { get :create_from_xml, :plan => {:xml => BadXml.new} }
    should_redirect_to "plans_url"
    should_respond_with :redirect
  end

  context "on POST to :create_from_xml good" do
    step = Factory(:step)
    setup { get :create_from_xml, :plan => {:xml => GoodXml.new} }
    should_redirect_to "plans_url"
    should_respond_with :redirect
  end

  context "on PUT to :clear_results" do
    step = Factory(:step)
    setup { put :clear_results, :id => step.scenario.plan.id }
    should_redirect_to "plan_scenarios_url(@plan)"
    should_respond_with :redirect
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

class BadXml
  def read
    <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<plan>
</plan>
EOF
  end
end

class GoodXml
  def read
    <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<plan>
  <created-at type="datetime">2009-03-01T17:11:20Z</created-at>
  <name>Fake</name>
  <updated-at type="datetime">2009-03-01T17:11:20Z</updated-at>
  <features type="array">
    <feature>
      <created-at type="datetime">2009-03-01T17:11:29Z</created-at>
      <name>Feature</name>
      <updated-at type="datetime">2009-03-01T17:11:29Z</updated-at>
      <scenarios type="array">
        <scenario>
          <created-at type="datetime" nil="true"></created-at>
          <name>Scenario</name>
          <position type="integer">1</position>
          <requirement>requirement</requirement>
          <result nil="true"></result>
          <setup>setup</setup>
          <updated-at type="datetime">2009-03-01T17:11:53Z</updated-at>
          <steps type="array">
            <step>
              <created-at type="datetime">2009-03-01T17:11:41Z</created-at>
              <description>Step</description>
              <expected>Step</expected>
              <position type="integer">1</position>
              <updated-at type="datetime">2009-03-01T17:11:41Z</updated-at>
            </step>
          </steps>
        </scenario>
      </scenarios>
    </feature>
  </features>
</plan>
EOF
  end

end
