Rails.application.routes.draw do
  root to: 'rankings#index'
  resources :rankings, only: [:index]
end
