Rails.application.routes.draw do
  devise_for :users
  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end
  
  resources :charges, only: [:new, :create]

  get 'welcome/index'

  get 'welcome/about'

  get 'downgrade' => 'charges#downgrade'

  root 'welcome#index'
end
