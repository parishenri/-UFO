Rails.application.routes.draw do

  get 'bookings/new'
  get 'bookings/edit'
  get 'bookings/show'
  get 'bookings/index'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # resources :groups
    resources :items do
      # resources :bookings
    end
    # resources :reviews
end
