ActionController::Routing::Routes.draw do |map|

  map.resources :features
  map.resources :plans, :shallow => true do |plan|
    plan.resources :scenarios, :member => {:update_step_order => :put, :update_feature => :put} do |scenario|
      scenario.resources :steps
    end
  end

  map.root :controller => "plans"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
