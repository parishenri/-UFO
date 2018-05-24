Rails.application.routes.draw do

  devise_for :users

  get 'users/:id/dashboard', to: 'pages#dashboard', as: :dashboard
  get 'users/:id/user_profile', to: 'pages#user_profile', as: :user_profile
  get '/user_listing', to: 'pages#user_listing', as: :user_listing

  resources :users, only: [:edit, :update] do
    resources :bookings, only: :index
  end

  root to: 'pages#home'

  resources :items do
    resources :bookings, except: [:index]
  end
end


