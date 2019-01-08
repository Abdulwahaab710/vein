# frozen_string_literal: true

class FindBloodDonorJob < TwilioJob
  queue_as :find_donor

  def perform
  end
end
