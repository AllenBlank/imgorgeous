Rails.application.routes.draw do
  resources :items, only: [:index, :show, :create, :update, :destroy]

  root 'static#index'
end
