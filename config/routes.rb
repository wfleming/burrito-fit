require 'sidekiq/web'

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Sidekiq::Web => '/sidekiq'

  root 'main#index'

  # OmniAuth expected route for auth callbacks
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get '/auth/failure', to: 'sessions#failure'
  resource :sessions, only: [:destroy]

  # the app dashboard
  resource :app_dashboard, controller: 'app_dashboard', only: [:show] do
    member do
      get :begin_sign_in
      get :finished_sign_in
    end
  end

  namespace :webhooks do
    post '/fitbit/subscription_update' => 'fitbit#subscription_update'
  end
end
