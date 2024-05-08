Rails.application.routes.draw do
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
  get 'pages/users'
  get 'pages/admins'
  # config/routes.rb
  post 'toggle_theme', to: 'pages#toggle_theme'

  # get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
end
