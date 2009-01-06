require 'test_helper'

class SetupsControllerTest < ActionController::TestCase
  should_route :get, '/scenarios/1/setup/edit', :controller => :setups, :action => :edit, :scenario_id => 1
  should_route :get, '/scenarios/1/setup', :controller => :setups, :action => :show, :scenario_id => 1
  should_route :put, '/scenarios/1/setup', :controller => :setups, :action => :update, :scenario_id => 1
end
