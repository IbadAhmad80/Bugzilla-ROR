Rails.application.routes.draw do
  get 'bugs/new'
  get 'bugs/create'
  get 'bugs/show'
  root to:'sessions#new'
  get 'sessions/new'
  get '/signup', to: 'users#new'
  resources :users, only: [:new, :create, :show,:index,:update,:edit]
  get '/login', to: 'sessions#new'
  post '/login',to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :bugs, only: [:index,:new, :create, :show, :edit, :update]
  resources :comments, only: [:new,:create]
end
