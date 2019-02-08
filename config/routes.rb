# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'static_pages#index'

  post '/locales/change', to: 'locales#change', as: :change_locale

  get '/signup', to: 'users#new', as: :signup
  post '/signup', to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/cities/:id', to: 'cities#show'

  get '/confirm_phone', to: 'users#confirm_phone_number', as: :confirm_phone_number
  post '/confirm_phone', to: 'users#verify_phone_number'

  get '/settings/profile', to: 'users#edit', as: :edit_user
  patch '/settings/profile', to: 'users#update'

  post '/resend_confirm_code', to: 'users#resend_confirm_code', as: :resend_confirm_code

  scope :blood_donations do
    get '/requests', to: 'blood_donation_requests#index', as: :blood_donation_requests

    get '/requests/new', to: 'blood_donation_requests#new', as: :request_blood_donation
    post '/requests/new', to: 'blood_donation_requests#create'

    delete '/requests/:id', to: 'blood_donation_requests#destroy', as: :blood_donation_request_withdraw
  end

  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
end
