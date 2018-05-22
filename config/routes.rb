Rails.application.routes.draw do

  devise_for :users

  get 'users/:id/dashboard', to: 'pages#dashboard', as: :dashboard
  get 'users/:id/user_profile', to: 'pages#user_profile', as: :user_profile

  resources :users, only: [:edit, :update]

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # resources :groups
    resources :items do
      # resources :bookings
    end
    # resources :reviews
end
