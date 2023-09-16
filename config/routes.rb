Rails.application.routes.draw do
  get 'search', to: 'search#index'
  devise_for :users
  root to: "pages#home"
  resources :expenses
  resources :incomes
  get "new", to: "pages#new", as: :new_pages
  post "", to: "pages#create"
end
