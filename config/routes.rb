Rails.application.routes.draw do
  root to:'sessions#new'
  get 'sessions/new'
  get '/signup', to: 'users#new'
  resources :users, only: [:new, :create, :show]
  get '/login', to: 'sessions#new'
  post '/login',to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
