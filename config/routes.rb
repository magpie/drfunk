Drfunk::Application.routes.draw do

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

    shallow do
      resources :scenarios do
        member do
          post :duplicate
          put :update_step_order
        end

        resources :steps
        resource :setup
        resource :requirement
        resource :result
      end
    end
  end

  match '/credits' => 'plans#credits', :as => :credits
  match '/' => 'plans#index'
end
