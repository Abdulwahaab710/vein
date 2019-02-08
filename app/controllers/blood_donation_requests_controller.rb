# frozen_string_literal: true

class BloodDonationRequestsController < ApplicationController
  def index
    @blood_requests = current_user&.blood_donation_requests&.where&.not(status: BloodDonationRequestStatus::WITHDRAWN)
    @cancelled_blood_requests = current_user&.blood_donation_requests&.where(
      status: BloodDonationRequestStatus::WITHDRAWN
    )
  end

  def new
    @blood_request = BloodDonationRequest.new
  end

  def create
    @blood_request = BloodDonationRequest.new(
      user: current_user, amount: blood_request_params[:amount],
      status: BloodDonationRequestStatus::MATCHING_IN_PROGRESS
    )
    return render :new unless @blood_request.save

    # call job
    redirect_to blood_donation_requests_path
  end

  def destroy
    current_user&.blood_donation_requests&.find_by(id: params[:id])&.update(
      status: BloodDonationRequestStatus::WITHDRAWN
    )
  end

  private

  def blood_request_params
    params.require(:blood_donation_request).permit(:amount)
  end
end
