ActionController::Routing::Routes.draw do |map|

  map.resources :features, :member => {:update_scenario_order => :put}
  map.resources :plans, :shallow => true do |plan|
    plan.resources :scenarios, :member => {:update_step_order => :put, :duplicate => :post} do |scenario|
      scenario.resources :steps
      scenario.resource :setup
    end
  end

  map.root :controller => "plans"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
