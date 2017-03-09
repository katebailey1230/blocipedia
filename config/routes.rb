Rails.application.routes.draw do
  resources :wikis

  get 'about' => 'welcome#about'
  
  devise_for :users
  resources :users
  resources :charges, only: [:new, :create]  
  resources :wikis
    
  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
