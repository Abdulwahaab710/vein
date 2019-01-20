# frozen_string_literal: true

class FindBloodDonorJob < TwilioJob
  queue_as :find_donor

  def perform(user, amount)
    update_user_to_recipient(user)
    blood_types = find_compatible_blood_types(user.blood_type)
    donors = find_available_donors(blood_types)
    notify_and_donors_status(donors, amount)
  end

  private

  def update_user_to_recipient(user)
    user.update(is_recipient: true, is_donor: false)
  end

  def find_compatible_blood_types(blood_type)
    blood_type.can_receive_from
  end

  def find_available_donors(blood_types)
    available_donor_status = DonorStatus.find_by(status: 'Available')
    blood_types.map do |blood_type|
      User.where(blood_type: blood_type, is_donor: true, donor_status: available_donor_status)
    end.flatten
  end

  def notify_and_donors_status(donors, amount)
    cnt = 0
    donors.each do |donor|
      break if cnt >= amount

      next unless update_donor_status(donor)
      next unless notify_donor(donor)

      cnt += 1
    end
  end

  def notify_donor(donor)
    message = 'You have been matched'
    puts "#{donor.phone} - #{message}"
    # send_sms_message(donor.phone, message)
    true
  end

  def update_donor_status(donor)
    donor.with_lock do
      donor.update(donor_status: matching_status)
    end
  end

  def matching_status
    @matching_status ||= DonorStatus.find_by(status: 'Matching in progress')
  end
end
