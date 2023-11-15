Rails.application.routes.draw do
  devise_for :users
  resources :articles do 
    resources :comments
  end 
  resources :users do
    member { patch 'incr_balance' }
    member { patch 'decr_balance' }
  end
  resources :users do
    resources :articles do
      resources :comments
    end
  end
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "articles#index"
end
