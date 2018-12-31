# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    context 'when the user is not logged in' do
      before(:each) { get :new }

      it 'renders template new' do
        expect(response).to render_template('new')
      end

      it 'returns success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST #create' do
    before(:each) { FactoryBot.create(:user) }

    context 'when signing in with a valid user' do
      before(:each) do
        post :create, params: { session: session_params }
      end

      it 'redirects to root_path' do
        expect(response).to redirect_to(confirm_phone_number_path)
      end
    end

    context 'when users params are missing' do
      before(:each) { post :create }

      it 'flashes with an error messaage' do
        expect(flash[:error]).to eq(t('missing_required_params'))
      end

      it 'returns an http_status with bad_request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'renders template new' do
        expect(response).to render_template('new')
      end
    end

    context 'when the phone is invalid' do
      before(:each) do
        post :create, params: { session: { phone: session_params[:phone], password: 'invalid' } }
      end

      it 'renders template new' do
        expect(response).to render_template('new')
      end

      it 'returns an http_status with unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'flashes with an error message' do
        expect(flash[:error]).to eq(t('invalid_phone_or_password'))
      end
    end

    context 'when the password is invalid' do
      before(:each) do
        post :create, params: { session: { phone: session_params[:phone], password: 'invalid' } }
      end

      it 'renders template new' do
        expect(response).to render_template('new')
      end

      it 'returns an http_status with unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'flashes with an error message' do
        expect(flash[:error]).to eq(t('invalid_phone_or_password'))
      end
    end

    context 'when the phone and password is invalid' do
      before(:each) do
        post :create, params: { session: { phone: 'invalid_phone', password: 'invalid_password' } }
      end

      it 'renders template new' do
        expect(response).to render_template('new')
      end

      it 'returns an http_status with unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'flashes with an error message' do
        expect(flash[:error]).to eq(t('invalid_phone_or_password'))
      end
    end
  end

  private

  def session_params
    { phone: '123456789', password: 'password123' }
  end
end
