Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#welcome'
  resources :sessions, only: [:create]
  match 'sign_out' => 'sessions#destroy', via: :delete
  resources :videos, only: [:index, :show]
end
