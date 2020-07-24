Rails.application.routes.draw do
  get '/health', controller: :elb, action: :health
  get '/privacy_policy', controller: :privacy_policy, action: :index
  root to: 'rankings#index'
  resources :rankings, only: [:index]
end
