# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :user_logged_in?
  before_action :user_confirmed?

  include Sessions

  private

  def set_locale
    I18n.locale = session_locale_or_accept_language_header_locale
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  def session_locale_or_accept_language_header_locale
    logger.debug "* session[:locale]: #{session[:locale]}"
    session[:locale] || extract_locale_from_accept_language_header
  end

  def extract_locale_from_accept_language_header
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
  end

  def user_logged_in?
    return if logged_in?

    store_location
    flash[:error] = t('please_login')
    redirect_to login_url
  end

  def user_confirmed?
    return redirect_to confirm_phone_number_path unless current_user&.confirmed?
  end
end
