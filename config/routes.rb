Rails.application.routes.draw do
  root 'main#index'

  # OmniAuth expected route for auth callbacks
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get '/auth/failure', to: 'sessions#failure'
end
