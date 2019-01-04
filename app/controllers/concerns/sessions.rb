# frozen_string_literal: true

module Sessions
  extend ActiveSupport::Concern

  def log_in(user)
    current_session = Session.create(
      user: user,
      ip_address: request.remote_ip,
      user_agent: request.user_agent
    )
    session[:user_session_id] = current_session&.id
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def current_user
    @current_session ||= Session.find_by(id: session[:user_session_id])
    return @current_session.user if !@current_session.nil? && @current_session.class == Session
  end

  def logged_in?
    !current_user.nil?
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get? && request.original_fullpath != '/login'
  end
end
