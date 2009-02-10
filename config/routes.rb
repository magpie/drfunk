ActionController::Routing::Routes.draw do |map|

  map.resources :features, :member => {:update_scenario_order => :put}
  map.resources :plans, 
    :member => {:search => :get, :clear_results => :put}, 
    :collection => {:search => :get, :create_from_xml => :post}, 
    :shallow => true do |plan|
    plan.resources :scenarios, :member => {:update_step_order => :put, :duplicate => :post} do |scenario|
      scenario.resources :steps
      scenario.resource :setup
      scenario.resource :requirement
      scenario.resource :result
    end
  end

  map.credits '/credits', :controller => 'plans', :action => 'credits'

  map.root :controller => "plans"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
