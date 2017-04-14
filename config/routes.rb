Rails.application.routes.draw do
  get 'static_pages/home'

  devise_for :users

  authenticated :user do
    root to: 'static_pages#home', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_out', to: 'devise/sessions#destroy'
    get 'sign_up', to: 'devise/registrations#new'
  end

  resources :appointments, only: [:edit, :update, :index]

  resources :users, only: [:destroy] do
    resources :appointments, module: 'users', only: :index
  end

  get '/account', to: 'users#show'
  get '/account/edit', to: 'devise/registrations#edit'
  get '/client_list', to: 'users#index'

  namespace :therapist do
    resources :appointments, except: [:show, :index]
  end
end
