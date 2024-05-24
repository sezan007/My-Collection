Rails.application.routes.draw do

  
  get 'items/show'
  get 'items/new'
  get 'items/edit'
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
  # get 'collections/new', to: 'collections#new'
  # get 'collections/:id', to: 'collections#show', as: :collection
  patch 'collections/:id', to: 'collections#update'
  resources :collections do
    resources :items
    resources :fields, only: [:destroy]
  end

  # get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
end
