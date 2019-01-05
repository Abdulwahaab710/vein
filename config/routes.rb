# frozen_string_literal: true

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
end
