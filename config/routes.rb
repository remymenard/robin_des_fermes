Rails.application.routes.draw do
  scope '(:locale)', locale: /fr/ do
    devise_for :users
    root to: 'pages#home'
    post 'set_zip_code', to: 'users#set_zip_code'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
