Rails.application.routes.draw do
  resources :suggestions, only: [:create]


end
