Rails.application.routes.draw do
  
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :followings
      get :followers
    end
    collection do
      get :search
    end
  end
  
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :likes
    end
  end
  
 
  resources :wants
  resources :prefectures
  resources :relationships, only: [:create, :destroy] 
  resources :favorites
  
  get 'prefectures/show/:id' => 'prefectures#show'
  end
