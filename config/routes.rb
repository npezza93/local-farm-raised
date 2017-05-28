# frozen_string_literal: true

Rails.application.routes.draw do
  resources :plans, only: %i(index new create destroy)
  resources :recipes
  resources :posts

  resources :addresses, except: :show
  resources :credit_cards, except: %i(show edit update)

  resources :users, only: [:index] do
    resources :subscriptions, only: %i(index new create)
  end

  put "users/:id", to: "users#admin", as: "admin"

  devise_for :users, controllers: { registrations: "registrations" }

  resources :orders, except: %i(edit update)
  resources :line_items, only: %i(create update)
  resource :cart, only: :show

  resources :products

  get "store", to: "products#index"

  root "products#index"
end
