# frozen_string_literal: true

class LocalesController < ApplicationController
  skip_before_action :user_logged_in?, only: :change
  skip_before_action :user_confirmed?, only: :change

  def change
    return head_bad_request_and_log_error unless I18n.available_locales.include?(params[:locale].to_sym)

    session[:locale] = params[:locale]
    logger.info "* Locale was changed to #{params[:locale]}"
  end

  private

  def head_bad_request_and_log_error
    head :bad_request
    logger.error "[X] Invalid locale #{params[:locale]}"
  end
end
