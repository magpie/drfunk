require 'test_helper'

class PlansControllerTest < ActionController::TestCase
  should_route :get, '/plans', :controller => :plans, :action => :index
  should_route :get, '/plans/1/edit', :controller => :plans, :action => :edit, :id => 1
  should_route :get, '/plans/1', :controller => :plans, :action => :show, :id => 1
  should_route :post, '/plans', :controller => :plans, :action => :create
  should_route :put, '/plans/1', :controller => :plans, :action => :update, :id => 1
  should_route :delete, '/plans/1', :controller => :plans, :action => :destroy, :id => 1

=begin
  context "on GET to :show" do
    setup { get :show, :id => 1 }
    should_assign_to :plan
    should_respond_with :success
    should_render_template :show
  end

  context "on POST to :create" do
    setup { post :create, :user => {:name => "A new plan"} }
    should_assign_to :plan
  end
=end

end
