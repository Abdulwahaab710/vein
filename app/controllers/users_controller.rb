# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :user_logged_in?, only: %i[new create]
  skip_before_action :user_confirmed?, only: %i[new create]

  include Sessions

  def create
    @user = User.new(user_params)
    return render :new, status: :bad_request unless @user.save!

    SendConfirmationCodeJob.perform_later(@user)
    flash[:success] = t('signup_success_flash')
    redirect_to confirm_phone_number_path
  rescue ActionController::ParameterMissing
    flash[:error] = t('missing_required_params')
    render :new, status: :bad_request
  end

  def new
    return redirect_back_or root_path if logged_in?

    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :password, :password_confirmation)
  end
end
