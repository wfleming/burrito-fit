require 'sidekiq/web'

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Sidekiq::Web => '/sidekiq'
  
  root 'main#index'

  # OmniAuth expected route for auth callbacks
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get '/auth/failure', to: 'sessions#failure'
  resource :sessions, only: [:destroy]

  namespace :webhooks do
    post '/fitbit/subscription_update' => 'fitbit#subscription_update'
  end
end
