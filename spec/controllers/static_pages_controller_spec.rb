# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET index' do
    context 'when the user request index' do
      before(:each) { get :index }

      it 'returns success' do
        expect(response).to be_successful
      end

      it 'renders index.html.erb' do
        expect(response).to render_template('index')
      end
    end
  end
end
