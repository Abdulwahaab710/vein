# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocalesController, type: :controller do
  describe 'POST #change' do
    context 'when the locale is valid' do
      it 'returns http success' do
        post :change, params: { locale: 'en' }
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the locale is invalid' do
      let(:locale) { 'arrrrr' }

      it 'returns http bad_request' do
        post :change, params: { locale: locale }
        expect(response).to have_http_status(:bad_request)
      end

      it 'logs the error' do
        expect(Rails.logger).to receive(:error).with(/Invalid locale/)
        post :change, params: { locale: locale }
      end
    end
  end
end
