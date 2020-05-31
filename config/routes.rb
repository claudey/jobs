# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pages/terms'
  get 'pages/updates'
  root to: 'pages#index'

  get 'about'   => 'pages#about'
  get 'help'    => 'pages#help'
  get 'pricing' => 'pages#pricing'
  get 'privacy' => 'pages#privacy'
  get 'terms'   => 'pages#terms'
  get 'updates' => 'pages#updates'

  get 'profile' => 'profile#show'

  resources :companies
  resources :jobs do
    collection do
      get 'search'
    end

    member do
      post 'filled'
      post 'vacant'
      post 'renew'
    end
  end

  devise_for :users, skip: %i[sessions registrations passwords], controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    # sessions
    get    'login',  to: 'devise/sessions#new',     as: :new_user_session
    post   'login',  to: 'devise/sessions#create',  as: :user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session

    # registrations
    put    '/account',  to: 'devise/registrations#update'
    delete '/account',  to: 'devise/registrations#destroy'
    post   '/account',  to: 'devise/registrations#create'
    get    '/register', to: 'devise/registrations#new',    as: :new_user_registration
    get    '/account',  to: 'devise/registrations#edit',   as: :edit_user_registration
    patch  '/account',  to: 'devise/registrations#update', as: :user_registration
    get    '/account/cancel', to: 'devise/registrations#cancel', as: :cancel_user_registration

    # passwords
    get   'new-pass',  to: 'devise/passwords#new',    as: :new_user_password
    get   'edit-pass', to: 'devise/passwords#edit',   as: :edit_user_password
    patch 'edit-pass', to: 'devise/passwords#update', as: :update_user_password
    post  'new-pass',  to: 'devise/passwords#create', as: :user_password
  end
end
