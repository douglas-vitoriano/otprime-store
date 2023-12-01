Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"
  resources :settings, only: [:index] do
    collection do
      get :password
      patch :update_user
      patch :update_password
    end
  end

  resources :addresses

  namespace :admin do
    root to: "home#index"
    resources :categories
    resources :products
  end
end

=begin
 em controllers de MVC existe três tipos de actions(por deaful):
  - actions de coleção: index, new, create
  - actions de membro: show, edit, update, destroy 


  estudar sobre "soft delete"
=end
