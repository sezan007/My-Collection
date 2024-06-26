Rails.application.routes.draw do
  get 'tickets/new'
  get 'tickets/create'
  get 'tickets/index'

  get 'collections/index'
  get 'collections/show'
  get 'admins/admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users do
    collection do
      patch :bulk_update
      delete :bulk_delete
    end
  end
  resources :collections
  get 'pages/users'
  get 'pages/admins'
  # config/routes.rb
  post 'toggle_theme', to: 'pages#toggle_theme'
  get 'toggle_theme', to: 'pages#toggle_theme'
  get 'mycollection', to: 'pages#mycollection'
  # get 'collections/new', to: 'collections#new'
  # get 'collections/:id', to: 'collections#show', as: :collection
  patch 'collections/:id', to: 'collections#update'
  resources :collections do
    resources :items do
      resource :likes, only: [:create,:destroy]
      resources :comments,only: [:create, :destroy,:edit,:update]
    end
    resources :fields, only: [:destroy,:new]
  end
  resources :items do
    collection do
      post :search
    end
  end
  resources :tickets, only: [:new, :create, :index, :destroy]
  resources :users, only: [:show]
  # Add a route for the help link
  get 'help', to: 'tickets#new'
  resources :users do
    post :generate_api_token, on: :member
  end
  namespace :api do
    namespace :v1 do
      resources :collections, only: [:index]
    end
  end
  
  
  
  # get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
end
