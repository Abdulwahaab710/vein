# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Session, type: :model do
  let(:user) { FactoryBot.create(:user) }
  context 'when creating a session' do
    it 'is valid with valid attributes' do
      expect(Session.new(user: user, user_agent: 'chrome', ip_address: '127.0.0.1')).to be_valid
    end

    it 'is invalid without a user_agent' do
      expect(Session.new(user: user, user_agent: 'chrome', ip_address: nil)).not_to be_valid
    end

    it 'is invalid without an ip_address' do
      expect(Session.new(user: user, user_agent: 'chrome', ip_address: nil)).not_to be_valid
    end
  end

  context 'when calling #delete on a session' do
    before :each do
      session = Session.create!(user: user, user_agent: 'chrome', ip_address: '127.0.0.1')
      session.delete
    end

    it 'soft deletes the record' do
      expect(Session.unscoped.where(is_deleted: true).first).not_to eq(nil)
    end

    it 'updates is_deleted to true' do
      expect(Session.unscoped.first.is_deleted).to eq(true)
    end
  end
end
