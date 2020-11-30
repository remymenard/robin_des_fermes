Rails.application.routes.draw do
  scope '(:locale)', locale: /fr/ do
    devise_for :users
    root to: 'pages#home'

    namespace :users do
      resource :zip_code, only: [:update]
    end

    resources :farms, only: [:index, :show]
    
    resources :orders, only: [:show] do
      resources :payments, only: [:new], controller: 'orders/payments'
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
end
