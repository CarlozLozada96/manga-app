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

  resources :manga, only: [:index, :show] do
    member do
      get 'chapter_pages/:chapter_id', to: 'manga#chapter_pages', as: :manga_chapter_pages_manga
    end
  end

  # Define routes for comments, allowing only create, edit, update, and destroy actions
  resources :comments, only: [:create, :edit, :update, :destroy]

  # Custom route for signing out users
  delete '/users/sign_out', to: 'users/sessions#destroy'
  
  # Admin namespace for managing users
  namespace :admin do
    resources :users, only: [:index] do
      member do
        patch :ban
        patch :unban
      end
    end
  end

  # Example custom route
  # get "/test" => "manga#test"
end
