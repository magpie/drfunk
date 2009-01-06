require 'test_helper'

class RequirementsControllerTest < ActionController::TestCase
  should_route :get, '/scenarios/1/requirement/edit', :controller => :requirements, :action => :edit, :scenario_id => 1
  should_route :get, '/scenarios/1/requirement', :controller => :requirements, :action => :show, :scenario_id => 1
  should_route :put, '/scenarios/1/requirement', :controller => :requirements, :action => :update, :scenario_id => 1
end
