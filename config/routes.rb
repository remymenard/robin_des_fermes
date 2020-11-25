Rails.application.routes.draw do
  scope '(:locale)', locale: /fr/ do
    devise_for :users
    root to: 'pages#home'

    resources :orders, only: [:show]
    post '/payment_webhook', to: 'orders#payment_webhook'
    get '/payment_success', to: 'orders#payment_success'
    get '/payment_cancel', to: 'orders#payment_cancel'
    get '/payment_error', to: 'orders#payment_error'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
