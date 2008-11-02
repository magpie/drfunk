ActionController::Routing::Routes.draw do |map|
  map.resources :steps, :member => {:unformatted_description => :put, :unformatted_verify => :put}
  map.resources :use_cases
  map.resources :plans
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
