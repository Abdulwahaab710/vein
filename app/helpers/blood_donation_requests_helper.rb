# frozen_string_literal: true

module BloodDonationRequestsHelper
  def status_label_color(status)
    return 'uk-label-success' if status == BloodDonationRequestStatus::MATCHED

    'uk-label-warning'
  end
end
