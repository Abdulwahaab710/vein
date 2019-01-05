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

      it 'flashes with an error messaage' do
        expect(flash[:error]).to eq(t('missing_required_params'))
      end

      it 'returns an http_status with bad_request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'GET #confirm_phone_number' do
    context 'when the user has not verified their number' do
      before(:each) do
        user = FactoryBot.create(:user)
        FactoryBot.create(:session, user: user)

        login_as user
        get :confirm_phone_number
      end

      it 'renders template confirm_phone_number' do
        expect(response).to render_template('confirm_phone_number')
      end

      it 'returns success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the user has verified their number' do
      before(:each) do
        user = FactoryBot.create(:user, phone_confirmed: true)
        FactoryBot.create(:session, user: user)

        login_as user
        get :confirm_phone_number
      end

      it 'redirects to edit_user_path' do
        expect(response).to redirect_to(edit_user_path)
      end

      it 'returns http_status redirect' do
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'POST #verify_phone_number' do
    let(:user) { FactoryBot.create(:user, name: 'John') }
    let(:verify_phone_number_params) { { confirm_phone_number: { confirmation_code: user.confirm_token } } }

    context 'when the user passes a valid confirmation_code' do
      before :each do
        FactoryBot.create(:session, user: user)
        login_as user
      end

      it 'changes phone_confirmed to true' do
        expect { post :verify_phone_number, params: verify_phone_number_params }
          .to change { User.last.phone_confirmed? }.from(false).to(true)
      end

      it 'removes confirm_token' do
        expect { post :verify_phone_number, params: verify_phone_number_params }
          .to change { User.last.confirm_token }.from(user.confirm_token).to(nil)
      end

      it 'redirects to edit_user_path' do
        post :verify_phone_number, params: verify_phone_number_params
        expect(response).to redirect_to(edit_user_path)
      end
    end

    context 'when the user passes an invalid token' do
      before :each do
        user = FactoryBot.create(:user, name: 'John')
        FactoryBot.create(:session, user: user)
        login_as user

        post :verify_phone_number, params: { confirm_phone_number: { confirmation_code: 'invalid_token' } }
      end

      it 'flashes with an error' do
        expect(flash[:error]).to eq(t('invalid_code'))
      end

      it 'returns an http_status with bad_request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'renders template new' do
        expect(response).to render_template('confirm_phone_number')
      end
    end
  end

  describe 'GET #edit' do
    before :each do
      user = FactoryBot.create(:user, phone_confirmed: true)
      FactoryBot.create(:session, user: user)

      login_as user
      get :edit
    end

    it 'renders template edit' do
      expect(response).to render_template('edit')
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    let(:user) { FactoryBot.create(:user, name: 'John', phone_confirmed: true, district: nil, city: nil) }
    let(:district) { FactoryBot.create(:district) }
    let(:blood_type) { FactoryBot.create(:blood_type, name: 'A+') }

    context 'when the user submit a valid form' do
      before :each do
        FactoryBot.create(:session, user: user)
        @name = 'Abdulwahaab Ahmed'

        login_as user
        patch :update, params: { user: {
          name: @name,
          district_id: district.id,
          city_id: district.city.id,
          blood_type_id: blood_type.id
        } }
      end

      it 'redirects to edit' do
        expect(response).to redirect_to(edit_user_path)
      end

      it 'flashes with a success message' do
        expect(flash[:success]).to eq(t('successfully_updated_profile'))
      end

      it 'updates name' do
        expect(User.find(user.id).name).to eq(@name)
      end

      it 'updates district' do
        expect(User.find(user.id).district).to eq(district)
      end

      it 'updates city' do
        expect(User.find(user.id).city).to eq(district.city)
      end

      it 'updates blood_type' do
        expect(User.find(user.id).blood_type).to eq(blood_type)
      end
    end
  end

  describe 'GET #edit_phone_number' do
    before :each do
      user = FactoryBot.create(:user, phone_confirmed: true)
      FactoryBot.create(:session, user: user)

      login_as user
      get :edit_phone_number
    end

    it 'renders template edit_phone_number' do
      expect(response).to render_template('edit_phone_number')
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update_phone_number' do
    let(:user) { FactoryBot.create(:user, name: 'John', phone_confirmed: true) }

    context 'when the user submits a valid number' do
      before :each do |test|
        FactoryBot.create(:session, user: user)
        @phone = '711123123'

        login_as user
        patch :update_phone_number, params: { user: { phone: @phone } } unless test.metadata[:skip_before_each]
      end

      it 'redirects to confirm_phone_number' do
        expect(response).to redirect_to(confirm_phone_number_path)
      end

      it 'flashes with a success message' do
        expect(flash[:success]).to eq(t('successfully_updated_phone'))
      end

      it 'updates phone number' do
        expect(User.find(user.id).phone).to eq(@phone)
      end

      it 'updates user phone_confirmed to false' do
        expect(User.find(user.id).phone_confirmed).to eq(false)
      end

      it 'send confirmation code upon completing signup', :skip_before_each do
        ActiveJob::Base.queue_adapter = :test
        expect { patch :update_phone_number, params: { user: { phone: @phone } } }.to have_enqueued_job(SendConfirmationCodeJob)
          .with(User.find_by(phone: @phone))
      end
    end

    context 'when the user submits an invalid number' do
      before :each do |test|
        FactoryBot.create(:session, user: user)
        @phone = '7aaa11123123'

        login_as user
        patch :update_phone_number, params: { user: { phone: @phone } } unless test.metadata[:skip_before_each]
      end

      it 'renders template edit_phone_number' do
        expect(response).to render_template('edit_phone_number')
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
