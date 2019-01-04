# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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
    context 'when creating a valid user' do
      before(:each) do |test|
        post :create, params: { user: user_params } unless test.metadata[:skip_before_each]
      end

      it 'flashes with a success messaage' do
        expect(flash[:success]).to eq(t('signup_success_flash'))
      end

      it 'redirects to confirm_phone_number_path' do
        expect(response).to redirect_to(confirm_phone_number_path)
      end

      it 'send confirmation code upon completing signup', :skip_before_each do
        ActiveJob::Base.queue_adapter = :test
        expect { post :create, params: { user: user_params } }.to have_enqueued_job(SendConfirmationCodeJob)
          .with(User.find_by(phone: '123456789'))
      end
    end

    context 'when users params are missing' do
      before(:each) { post :create }

      it 'flashes with a success messaage' do
        expect(flash[:error]).to eq(t('missing_required_params'))
      end

      it 'returns an http_status with bad_request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  private

  def user_params
    { name: 'Abdulwahaab Ahmed', phone: '123456789', password: 'password', password_confirmation: 'password' }
  end
end
