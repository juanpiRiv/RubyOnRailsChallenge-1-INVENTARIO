Rails.application.routes.draw do
  resources :personas
  resources :articulos
  resources :transferencias
  root "personas#index"
end
