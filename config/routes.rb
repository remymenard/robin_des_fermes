Rails.application.routes.draw do
  devise_for :users
  scope '(:locale)', locale: /fr/ do
    root to: 'pages#home'
    resources :farms, only: [:index, :show]
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
