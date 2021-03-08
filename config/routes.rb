Rails.application.routes.draw do
  devise_for :users, controllers: {confirmations: 'users/confirmations', registrations: 'users/registrations', sessions: 'users/sessions'}
  ActiveAdmin.routes(self)

  devise_for :admin_users, {class_name: 'User'}.merge(ActiveAdmin::Devise.config)

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  scope '(:locale)', locale: /fr/ do
    root to: 'pages#home'
    get 'faq', to: 'pages#faq'
    resources :farms, only: [:index, :show]
    resources :products, only: [:show]
    get 'cgv', to: 'pages#cgv'
    get 'team', to: 'pages#team'
    get 'about', to: 'pages#about'
    get 'impressum', to: 'pages#impressum'
    get 'community', to: 'pages#community'
    get 'charter', to: 'pages#charter'
    get 'partners', to: 'pages#partners'
    get 'producer', to: 'pages#producer'
    get 'newsletter', to: 'pages#newsletter'
  end

  namespace :users do
    resource :zip_code, only: [:update]
    resource :delivery_infos, only: [:edit, :update]
    resource :admin, only: [] do
      get :search
    end
  end

  resources :farms

  resources :orders, only: [:show] do
    member do
      get :review
      get :delivery
      patch :update_delivery_methods
    end
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
    namespace :mails do
      resource :confirm_shipped, :controller => 'confirm_shipped', only: [] do
          get :set_as_shipped
          get :successful
          get :with_error
      end
    end
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
