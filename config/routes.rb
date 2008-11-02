ActionController::Routing::Routes.draw do |map|
  map.resources :steps

  map.resources :use_cases
  map.resources :plans
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
