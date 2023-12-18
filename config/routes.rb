Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"
  resources :settings, only: [:index] do
    collection do
      get :orders
      get :password
      patch :update_user
      patch :update_password
    end
  end

  resources :orders, only: [:new, :create, :show, :index]

  resources :addresses
  resources :carts, only: [:show, :create] do
    member do
      post "add_to_cart", to: "carts#add", as: "add_to_cart"
      post "update_cart", to: "carts#update_item", as: "update_cart"
      post "remove_from_cart", to: "carts#remove", as: "remove_cart_item"
      post "finalize_order", to: "orders#finalize", as: "finalize_order"
    end
    collection do
      post :create
    end
  end

  namespace :admin do
    root to: "dashboard#index"
    resources :categories
    resources :products
    resources :users do
      member do
        post :toggle_admin
      end
    end
  end
end

=begin
 em controllers de MVC existe três tipos de actions(por deaful):
  - actions de coleção: index, new, create
  - actions de membro: show, edit, update, destroy 


  estudar sobre "soft delete"
=end
