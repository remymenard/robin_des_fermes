Rails.application.routes.draw do
  scope '(:locale)', locale: /fr/ do
    devise_for :users
    root to: 'pages#home'

    resources :farms, only: [:index, :show]
    resources :products, only: [:show]
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
