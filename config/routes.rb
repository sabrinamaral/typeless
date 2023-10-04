Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  resources :expenses
  resources :incomes
  get "new", to: "pages#new", as: :new_pages
  post "", to: "pages#create"
end
