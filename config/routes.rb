Rails.application.routes.draw do

  resources :photos

  resources :products, only: [:new, :edit, :create, :update, :destroy]
  namespace :subscriptions do
    resources :products, only: [:index, :show] do
      resources :orders, only: [:create]
    end
  end
  namespace :purchases do
    resources :orders, only: [:index, :destroy] do
      collection do
        put :checkout
        get :cart
      end
    end
    resources :products, only: [:index, :show] do
      resources :orders, only: [:create]
    end
  end

  devise_for :users, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'register'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'purchases/products#index'
end
