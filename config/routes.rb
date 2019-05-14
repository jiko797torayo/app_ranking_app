Rails.application.routes.draw do
  root to: 'rankings/free_apps#index'
  namespace :rankings do
    resources :free_apps, only: [:index]
  end
end
