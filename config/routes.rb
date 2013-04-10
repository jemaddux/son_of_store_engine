StoreEngine::Application.routes.draw do
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
  resources :products do
    member do
      put :retire
      put :unretire
    end
  end

  resources :categories

  resources :users
  resource :session

  get "all_products" => "products#list"
  get "profile" => "users#show"
  get "my_cart" => "carts#show"
  get "admin" => "products#index", :as => "admin"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "search" => "search#user_search", :as => "search"

  namespace :admin do

    resources :products do
      member do
        post :retire
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

  resources :stores

  scope ":store_id", as: "store" do
    match "/" => "stores#show", as: "home"
  end

  root :to => 'home#show'
end
