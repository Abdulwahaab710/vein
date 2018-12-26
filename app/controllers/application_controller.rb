# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

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
end
