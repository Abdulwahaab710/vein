# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CitiesController, type: :controller do
  describe 'GET #show' do
    context 'when the city exist' do
      let(:district) { FactoryBot.create(:district) }

      before :each do
        user = FactoryBot.create(:user, phone_confirmed: true)
        FactoryBot.create(:session, user: user)

        login_as user

        get :show, params: { id: district.city.id }
      end

      it 'returns success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns all districts for a city' do
        expect(response.body).to eq(district.city.districts.select(:id, :name).to_json)
      end
    end

    context 'when the city does not have any districts' do
      let(:city) { FactoryBot.create(:city) }

      before :each do
        user = FactoryBot.create(:user, phone_confirmed: true)
        FactoryBot.create(:session, user: user)

        login_as user

        get :show, params: { id: city.id }
      end

      it 'returns an empty array' do
        expect(response.body).to eq([].to_s)
      end
    end
  end
end
