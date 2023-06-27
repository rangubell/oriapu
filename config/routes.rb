Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"
  resources :users, only: :show
  resources :schedules
  resources :departments, only: [:show]
  resources :paid_leaves, only: [:new, :create, :index]
  resources :leave_applications, only: [:new, :create, :index]
end
