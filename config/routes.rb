Rails.application.routes.draw do

  get 'about', to: 'pages#about', as: :about
  get 'contact', to: 'pages#contact', as: :contact
  get 'howworks', to: 'pages#howworks', as: :howworks
  get 'gettingstarted', to: 'pages#gettingstarted', as: :gettingstarted
  get 'FAQ', to: 'pages#FAQ', as: :FAQ
  get 'partners', to: 'pages#partners', as: :partners
  get 'careers', to: 'pages#careers', as: :careers

  devise_for :users

  get 'calendar/:id', to: 'pages#calendar', as: :calendar
  get '/user_listing', to: 'pages#user_listing', as: :user_listing
  get '/user_booking', to: 'pages#user_booking', as: :user_booking

  resources :users, only: [:edit, :update, :show] do
    resources :bookings, only: :index
  end

  resources :orders, only: [ :show, :create] do
    resources :payments, only: [:new, :create]
  end

  resources :items do
    resources :bookings, except: [:index]
    resources :reviews, only: [:create, :index, :destroy]
  end


  resources :conversations do
    resources :messages do
      get 'bookings/accept', to: 'bookings#accept'
      get 'bookings/decline', to: 'bookings#decline'
    end
  end

  root to: 'pages#home'

  ActiveAdmin.routes(self)
end


