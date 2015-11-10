Rails.application.routes.draw do
  resources :subscriptions
  resources :posts
  resources :recipes
  resources :posts

  resources :users, only: [:index] do
    resources :addresses, except: [:show]
    resources :credit_cards, except: [:show, :edit, :update]
  end

  put 'users/:id', to: "users#admin", as: "admin"

  devise_for :users, controllers: { registrations: "registrations" }

  resources :orders, except: [:edit, :update]
  resources :line_items, only: [:create, :update, :destroy]
  resources :carts, only: [:show, :create, :destroy]

  resources :products

  get 'store', to: "products#index"

  root 'products#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
end
