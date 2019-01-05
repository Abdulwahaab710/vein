# frozen_string_literal: true

module SessionsHelper
  def current_user
    @current_session ||= Session.find_by(id: session[:user_session_id])
    return @current_session.user if !@current_session.nil? && @current_session.class == Session
  end

  def logged_in?
    !current_user.nil?
  end
end
