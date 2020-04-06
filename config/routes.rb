Rails.application.routes.draw do
  root to: 'shops#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout',to: 'sessions#destroy'
  get 'category/:id',to: 'shops#category', as: 'category'
  get 'search', to: 'shops#search'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:new, :create]
  resources :items
  resources :shops
  resources :user_items
end
