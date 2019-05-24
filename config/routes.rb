Rails.application.routes.draw do
  root to: 'rankings/free_apps#index'
  namespace :rankings do
    resources :free_apps, only: [:index]
    resources :paid_apps, only: [:index]
    get 'itunes_music', to: 'itunes_music#index', as: 'itunes_music'
  end
end
