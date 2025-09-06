Rails.application.routes.draw do
  resources :transferencia
  resources :personas
  resources :articulos

  root "personas#index"
end
