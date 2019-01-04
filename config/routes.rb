# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'static_pages#index'

  post '/locales/change', to: 'locales#change', as: :change_locale

  get '/signup', to: 'users#new', as: :signup
  post '/signup', to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/confirm_phone', to: 'users#confirm_phone_number', as: :confirm_phone_number
end
