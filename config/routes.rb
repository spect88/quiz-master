Rails.application.routes.draw do

  # get /auth/auth0 also exists and is handled by OmniAuth middleware
  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'landing_pages#root'
end
