Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"

  resources :users

  get '/users/api/:key', to: 'apis#show'

end
