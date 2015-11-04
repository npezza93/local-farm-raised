Rails.application.routes.draw do
  resources :users, only: [:index] do
    resources :addresses, except: [:show]
  end
  get 'users/settings', to: 'users#settings', as: "settings"
  put 'users/:id', to: "users#admin", as: "admin"

  devise_for :users

  resources :orders
  resources :line_items, only: [:create, :update, :destroy]
  resources :carts, only: [:show, :create, :destroy]

  resources :products do
    get :who_bought, on: :member
  end

  get 'store', to: "products#index"

  root 'products#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
end
