Rails.application.routes.draw do
  get '/health', controller: :elb, action: :health
  root to: 'rankings#index'
  resources :rankings, only: [:index]
end
