Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :auth, only: [:create]

      post 'users/newplan', to: 'plans#create'
      patch 'users/complete-action/:id', to: 'actions#complete'
      delete 'users/goals/:id', to: 'goals#delete'
    end
  end
end
