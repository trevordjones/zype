Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#welcome'
  resources :sessions, only: [:create]
  resources :videos, only: [:index, :show]
end
