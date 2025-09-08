Rails.application.routes.draw do
  resources :personas
  resources :articulos
  resources :transferencias

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'

  root "personas#index"
end
