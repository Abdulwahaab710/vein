# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    I18n.locale = locale
  end

  def locale
    session[:locale] || locale_based_on_location
  end

  def locale_based_on_location
    'en'
  end
end
