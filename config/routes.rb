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

  namespace :api do
    namespace :v1 do
      resources :articulos, except: [:new, :edit]
      resources :personas, except: [:new, :edit]
      resources :transferencias, except: [:new, :edit]

      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
      post 'register', to: 'users#create'
    end
  end
end
