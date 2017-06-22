Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show, :update, :destroy]
      resources :auth, only: [:create]

      get 'usernames', to: 'users#index'
      post 'users/newplan', to: 'plans#create'
      patch 'users/complete-action/:id', to: 'actions#complete'
      delete 'users/actions/:id', to: 'actions#delete'
      delete 'users/goals/:id', to: 'goals#delete'
      delete 'users/plans/:id', to: 'plans#delete'
      patch 'plan/:id/edit', to: 'plans#update'
    end
  end
end
