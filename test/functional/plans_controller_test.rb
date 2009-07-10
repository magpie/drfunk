require 'test_helper'

class PlansControllerTest < ActionController::TestCase

  test "plan routes" do
    assert_recognizes({:controller => 'plans', :action => 'index'}, {:path => 'plans', :method => :get})
    assert_recognizes({:controller => 'plans', :action => 'edit', :id => '1'}, {:path => 'plans/1/edit', :method => :get})
    assert_recognizes({:controller => 'plans', :action => 'show', :id => '1'}, {:path => 'plans/1', :method => :get})
    assert_recognizes({:controller => 'plans', :action => 'create'}, {:path => 'plans', :method => :post})
    assert_recognizes({:controller => 'plans', :action => 'update', :id => '1'}, {:path => 'plans/1', :method => :put})
    assert_recognizes({:controller => 'plans', :action => 'destroy', :id => '1'}, {:path => 'plans/1', :method => :delete})
    assert_recognizes({:controller => 'plans', :action => 'search', :id => '1'}, {:path => 'plans/1/search', :method => :get})
    assert_recognizes({:controller => 'plans', :action => 'clear_results', :id => '1'}, {:path => 'plans/1/clear_results', :method => :put})
    assert_recognizes({:controller => 'plans', :action => 'create_from_xml'}, {:path => 'plans/create_from_xml', :method => :post})
    assert_recognizes({:controller => 'plans', :action => 'new'}, {:path => 'plans/new', :method => :get})
    assert_recognizes({:controller => 'plans', :action => 'credits'}, {:path => 'credits', :method => :get})
  end

  test "get new" do
    get :new
    assert_not_nil assigns(:plan)
    assert_response :success
    assert_template :new
  end

  test "get credits" do
    get :credits
    assert_response :success
    assert_template :credits
  end

  test "get search with query" do
    step = Factory(:step)
    get :search, :id => step.scenario.plan.id, :query => "abc"
    assert_not_nil assigns(:plan)
    assert_not_nil assigns(:scenarios)
    assert_response :success
    assert_template :search
  end

  test "get index" do
    5.times { Factory(:step) }
    get :index
    assert_not_nil assigns(:plans)
    assert_response :success
    assert_template :index
  end

  test "get show" do
    step = Factory(:step)
    get :show, :id => step.scenario.plan.id
    assert_not_nil assigns(:plan)
    assert_response :success
    assert_template :show
  end

  test "post create_from_xml bad" do
    step = Factory(:step)
    post :create_from_xml, :plan => {:xml => BadXml.new}
    assert_response :redirect
    assert_redirected_to plans_url
  end

  test "post to create_from_xml good" do
    step = Factory(:step)
    post :create_from_xml, :plan => {:xml => GoodXml.new}
    assert_response :redirect
    assert_redirected_to plans_url
  end

  test "put to clear_results" do
    step = Factory(:step)
    put :clear_results, :id => step.scenario.plan.id
    assert_response :redirect
    assert_redirected_to plan_scenarios_url(step.scenario.plan)
  end

  test "show_ajax" do
    step = Factory(:step)
    xhr :get, :show, :id => step.scenario.plan.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "plan"
  end

  test "delete to destroy" do
    step = Factory(:step)
    delete :destroy, :id => step.scenario.plan.id
    assert_response :redirect
    assert_redirected_to plans_url
  end

  test "destroy ajax" do
    step = Factory(:step)
    xhr :delete, :destroy, :id => step.scenario.plan.id
    assert_response :success
  end

  test "edit ajax" do
    step = Factory(:step)
    xhr :get, :edit, :id => step.scenario.plan.id
    assert_response :success
    assert_select_rjs :chained_replace_html, "plan"
  end

  test "update ajax" do
    step = Factory(:step)
    xhr :put, :update, :id => step.scenario.plan.id, :plan => {:name => "new name"}
    assert_response :success
    assert_select_rjs :chained_replace_html, "plan"
  end

  test "create ajax" do
    step = Factory(:step)
    xhr :post, :create, :id => step.scenario.plan.id, :plan => {:name => "new plan"}
    assert_response :success
    assert_select_rjs :chained_replace_html, "plan-list"
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
