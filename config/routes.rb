Rails.application.routes.draw do
  # Public
  root to: 'memories#index'

  resources :memories, only: [:index, :show]

  get 'screensaver', to: 'screensaver#index'

  # Admin
  namespace :admin do
    resources :locations
    resources :memories
  end
end
