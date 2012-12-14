Webmarks2::Application.routes.draw do
  
  resources :bookmarks
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  

  root to: 'users#home'
  
  match '/add', to: 'bookmarks#new'
  match '/view', to: 'bookmarks#view'
  
  match '/login', to: 'sessions#new'
  match '/logout', to: 'sessions#destroy'#, via: :delete
  
  match '/user', to: 'users#index'
  match '/view-user', to: 'users#view'
  match '/signup', to: 'users#new'
  match '/profile', to: 'users#show'
  
  
end
