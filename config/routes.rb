# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'static_pages#index'

  post 'locales/change', to: 'locales#change', as: :change_locale
end
