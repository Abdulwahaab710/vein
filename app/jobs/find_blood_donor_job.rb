# frozen_string_literal: true

class FindBloodDonorJob < TwilioJob
  queue_as :find_donor

  def perform(user, amount)
    blood_types = find_compatible_blood_types(user.blood_type)
    donors = find_available_donors(blood_types, amount)
    notify_and_donors_status(donors)
    update_donor_status(donor)
  end

  private

  def find_compatible_blood_types(blood_type)
  end

  def find_available_donors(blood_types, amount)
  end

  def notify_and_donors_status(donors)
    donors.each do |donor|
      next unless notify_donor(donor)

      update_donor_status(donor)
    end
  end

  def notify_donor(donor)
    message = 'You have been matched'
    send_sms_message(donor.phone, message)
  end

  def update_donor_status(donor)
  end
end
