# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BloodDonationRequestsController, type: :controller do
  describe 'GET #index' do
    before :each do
      user = FactoryBot.create(:user, phone_confirmed: true)
      FactoryBot.create(:session, user: user)

      login_as user
      get :index
    end

    it 'renders template index' do
      expect(response).to render_template('index')
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    before :each do
      user = FactoryBot.create(:user, phone_confirmed: true)
      FactoryBot.create(:session, user: user)

      login_as user
      get :new
    end

    it 'renders template new' do
      expect(response).to render_template('new')
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    before :each do
      user = FactoryBot.create(:user, phone_confirmed: true)
      FactoryBot.create(:session, user: user)

      login_as user
    end

    it 'returns success' do
      post :create, params: { blood_donation_request: { amount: 1 } }
      expect(response).to have_http_status(:redirect)
    end

    it 'creates a blood donation request' do
      expect { post :create, params: { blood_donation_request: { amount: 1 } } }
        .to change { BloodDonationRequest.count }.from(0).to(1)
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      user = FactoryBot.create(:user, phone_confirmed: true)
      FactoryBot.create(:session, user: user)
      @blood_donation_request = FactoryBot.create(:blood_donation_request, user: user, amount: 2)

      login_as user
    end

    it 'returns success' do
      delete :destroy, params: { id: @blood_donation_request.id }
      expect(response).to have_http_status(:no_content)
    end

    it 'creates a blood donation request' do
      expect { delete :destroy, params: { id: @blood_donation_request.id } }
        .to change { BloodDonationRequest.where(status: BloodDonationRequestStatus::WITHDRAWN).count }.from(0).to(1)
    end
  end
end
