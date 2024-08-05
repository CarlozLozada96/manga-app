Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "manga#index"

  # Define routes for manga, only index and show actions
  resources :manga, only: [:index, :show]

  # Define routes for comments, allowing only create, edit, update, and destroy actions
  resources :comments, only: [:create, :edit, :update, :destroy]

  # Custom route for signing out users
  delete '/users/sign_out', to: 'users/sessions#destroy'
end
