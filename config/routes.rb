require 'resque/server'

StoreEngine::Application.routes.draw do

  mount Resque::Server.new, at: "/resque"

  get "/orders/review/:confirmation_hash" => "orders#display", :as => "display"

  resources :trips

  resources :orders do
    member do
      put :change_status, :as => "change_status_on"
    end
  end

  match "code" => redirect("http://github.com/jemaddux/son_of_store_engine"), :as => :code

  resources :line_items do
    member do
      put :increase
      put :decrease
    end
  end

  resources :carts
  # resources :products do
  #   member do
  #     put :retire
  #     put :unretire
  #   end
  # end

  resources :categories

  resources :users
  resource :session

  get "all_products" => "products#list"
  get "user_profile" => "users#show"
  get "profile" => "home#profile"
  get "my_cart" => "carts#show"
  #get "admin" => "products#index", :as => "admin"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "search" => "search#user_search", :as => "search"
  get "/stores/pending/:path" => "stores#pending", :as => "pending"
  put "new/admin" => "admin/admin#new_admin"
  get "signup_admin" => "admin/admin#signup_admin"
  put "create_admin" => "admin/admin#create_admin"

  resources :stores

  namespace :admin do

    resources :stores do
      member do
        put :change_status, :as => "change_status_on"
      end
    end

    resources :products do
      member do
        put :retire
        put :unretire
      end
    end

    resources :orders do
      member do
        post :cancel
        post :return
        post :ship
        post :paid
        post :update_quantity
      end
    end

    resources :categories
  end

  scope ":store_id", as: "store" do
    match "/" => "stores#show", as: "home"
    match "/stock/products" => "admin/products#index", as: "index"
    match "/admin/products" => "admin/products#index", as: "index"
    match "/admin" => "admin/products#index", as: "index"

    resources :categories
  end

  root :to => 'home#show'
end
