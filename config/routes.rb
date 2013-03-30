StoreEngine::Application.routes.draw do
  resources :line_items do
    member do
      put :increase
      put :decrease
    end
  end

  resources :carts
  resources :products
  resources :categories

  resources :users
  resources :sessions

  get "admin" => "products#index", :as => "admin"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "home/show"

  root :to => 'home#show'
end
