Drfunk::Application.routes.draw do |map|

  resources :features do
    member do
      put :update_scenario_order
    end
  end

  resources :plans do
    member do
      put :clear_results
      get :failures
      get :search
    end

    collection do
      post :create_from_xml
    end

    resources :scenarios, :only => [:index, :new, :create]
  end

  resources :scenarios, :only => [:show, :edit, :update, :destroy] do
    member do
      post :duplicate
      put :update_step_order
    end

    resources :steps, :only => [:index, :new, :create]
    resource :setup
    resource :requirement
    resource :result
  end

  resources :steps, :only => [:show, :edit, :update, :destroy]

  match '/credits' => 'plans#credits', :as => :credits
  match '/' => 'plans#index'
#  match '/:controller(/:action(/:id))'
end
