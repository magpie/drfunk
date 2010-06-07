Drfunk::Application.routes.draw do |map|

  resources :features do
    member do
      put :update_scenario_order
    end
  end

  resources :plans do
    member do
      get :search
    end

    resources :scenarios do
      resources :steps
      resource :setup
      resource :requirement
      resource :result
    end
  end

  match '/credits' => 'plans#credits', :as => :credits
  match '/' => 'plans#index'
#  match '/:controller(/:action(/:id))'
end
