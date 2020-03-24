Rails.application.routes.draw do
  root to: 'sessions#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout',to: 'sessions#delete'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
end
