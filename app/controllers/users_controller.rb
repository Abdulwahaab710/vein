# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :user_logged_in?, only: %i[new create]
  skip_before_action :user_confirmed?, only: %i[new create confirm_phone_number verify_phone_number resend_confirm_code]

  include Sessions

  def create
    @user = User.new(user_params)
    return render :new, status: :bad_request unless @user.save

    SendConfirmationCodeJob.perform_later(@user, I18n.locale.to_s)
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

  def confirm_phone_number
    return redirect_to edit_user_path if current_user.phone_confirmed?
  end

  def verify_phone_number
    if params[:confirm_phone_number][:confirmation_code] == current_user.confirm_token
      current_user.update!(phone_confirmed: true, confirm_token: nil)
      redirect_to edit_user_path
    else
      logger.debug "[X] Failed attempt to verify phone number for #{current_user}"
      flash.now[:error] = t('invalid_code')
      render :confirm_phone_number, status: :bad_request
    end
  end

  def edit
    @user = current_user
    @blood_types = BloodType.pluck(:name, :id)
    @cities = cities_names_with_current_locale
    @districts = current_user.city&.districts&.pluck(:name, :id) || []
  end

  def update
    @user = current_user
    return render :edit, status: :bad_request unless @user.update(user_profile_params)

    flash[:success] = t('successfully_updated_profile')
    redirect_to edit_user_path
  end

  def resend_confirm_code
    return head :not_found if current_user.phone_confirmed?

    current_user.generate_confirm_token
    SendConfirmationCodeJob.perform_later(current_user, I18n.locale.to_s)
    head :success
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone, :password, :password_confirmation)
  end

  def user_profile_params
    params.require(:user).permit(:name, :district_id, :city_id, :blood_type_id, :is_donor)
  end

  def cities_names_with_current_locale
    return Country.find_by(name: 'Yemen')&.cities&.pluck(:ar_name, :id) if I18n.locale == :ar

    Country.find_by(name: 'Yemen')&.cities&.pluck(:name, :id)
  end
end
