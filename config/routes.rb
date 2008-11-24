ActionController::Routing::Routes.draw do |map|
  map.resources :features
  map.resources :steps
  map.resources :scenarios, 
    :member => {:update_step_order => :put, :update_feature => :put}
  map.resources :plans

  map.root :controller => "plans"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
