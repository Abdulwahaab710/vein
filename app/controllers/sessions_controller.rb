# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :user_logged_in?, only: %i[new create]
  skip_before_action :user_confirmed?, only: %i[new create destroy]

  include Sessions

  def new
    return redirect_back_or root_path if logged_in?

    render :new unless performed?
  end

  def create
    if user&.authenticate(session_params[:password])
      log_in user

      return redirect_to confirm_phone_number_path unless user.confirmed?
      return redirect_to_complete_your_profile if user.blood_type.nil?

      redirect_back_or root_path
    else
      flash.now[:error] = t('invalid_phone_or_password')
      render 'new', status: :unauthorized
    end
  rescue ActionController::ParameterMissing
    flash.now[:error] = t('missing_required_params')
    render :new, status: :bad_request
  end

  def destroy
    @current_session = Session.find_by(id: session[:user_session_id])
    @current_session.destroy
    session[:session_id] = nil
    redirect_to login_path
  end

  def user
    @user ||= User.find_by(phone: session_params[:phone])
  end

  def session_params
    params.require(:session).permit(:phone, :password)
  end
end
