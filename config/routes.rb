Rails.application.routes.draw do
  devise_for :users


  root to: "home#index"

  namespace :admin do
    root to: "home#index"
    resources :admins
  end
end



=begin
 em controllers de MVC existe três tipos de actions(por deaful):
  - actions de coleção: index, new, create
  - actions de membro: show, edit, update, destroy 


  estudar sobre "soft delete"
=end
