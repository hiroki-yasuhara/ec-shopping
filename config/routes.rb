Rails.application.routes.draw do
  root to: 'shops#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout',to: 'sessions#destroy'
  post 'category',to: 'shops#category'
  post 'result',to: 'shops#result'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
  resources :items
  resources :shops
  resources :user_items
end
