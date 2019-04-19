Rails.application.routes.draw do
  resources :rankings, only: [:index, :show]
  root to: 'rankings#index'
end
