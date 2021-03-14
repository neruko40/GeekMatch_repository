Rails.application.routes.draw do

  
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

  # get '/users/sign_up', to: 'users/registrations#new'
  # post '/users', to: 'users/registrations#create'
  # get '/users/edit', to: 'users/registrations#edit'
  # put '/users', to: 'users/registrations#update'
  # delete '/users', to: 'users/registrations#destroy'

  # get '/users/sign_in', to: 'users/sessions#new'
  # post '/users/sign_in', to: 'users/sessions#create'
  # delete '/users/sign_out', to: 'users/sessions#destroy'

  get '/unlocks/new', to: 'unlocks#new'
  post '/unlocks', to: 'unlocks#create'
  
  get '/users/password/new', to: 'divise/passwords#new'
  post '/users/password', to: 'devise/passwords#create'
  
  get '/confirmations/new', to: 'confirmations#new'
  post '/confirmations', to: 'confirmations#create'
  
  root to: 'pages#index'
  get 'pages/:id', to: 'pages#show'

  get 'users/show', to: 'users#show'
  get 'users_index', to: 'users#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
