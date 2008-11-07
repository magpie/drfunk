ActionController::Routing::Routes.draw do |map|
  map.resources :steps, 
    :member => {:unformatted_description => :put, :unformatted_verify => :put}
  map.resources :use_cases, :member => {:update_step_order => :put}
  map.resources :plans

  map.root :controller => "plans"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
