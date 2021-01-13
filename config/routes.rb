Rails.application.routes.draw do
  devise_for :admin_users, {class_name: 'User'}.merge(ActiveAdmin::Devise.config)
  ActiveAdmin.routes(self)
  devise_for :users
  scope '(:locale)', locale: /fr/ do
    root to: 'pages#home'
    get 'faq', :to => 'pages#faq'
    resources :farms, only: [:index, :show]
    resources :products, only: [:show]
    get 'cgv', :to => 'pages#cgv'
  end

  namespace :users do
    resource :zip_code, only: [:update]
  end

  resources :farms, only: [:index, :show]

  resources :orders, only: [:show] do
    resources :payments, only: [:new], controller: 'orders/payments'
  end

  namespace :basket do
    resources :order_line_items, only: [:destroy] do
      member do
        post :increment
        post :decrement
      end
    end
  end

  namespace :orders do
    namespace :redirect do
      resources :payments, only: [] do
        collection do
          get :successful
          get :canceled
          get :with_error
        end
      end
    end
  end

  namespace :webhooks do
    namespace :datatrans do
      resources :payments, only: [:create]
    end
  end
end
