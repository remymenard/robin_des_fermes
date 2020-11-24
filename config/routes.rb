Rails.application.routes.draw do
  scope '(:locale)', locale: /fr/ do
    devise_for :users
    root to: 'pages#home'
    resources :orders do

      get '/payment', to: 'pages#payment'
      post '/payment', to: 'pages#payment_post'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
