Rails.application.routes.draw do

  resources :quizzes, only: [:show] do
    resources :results, only: [:create]
  end

  get '/dashboard' => 'dashboard#show', as: 'dashboard'

  # get /auth/auth0 also exists and is handled by OmniAuth middleware
  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/login', to: 'auth0#sign_in', as: 'sign_in'
  get '/auth/logout' => 'auth0#sign_out', as: 'sign_out'

  root to: 'landing_pages#root'
end
