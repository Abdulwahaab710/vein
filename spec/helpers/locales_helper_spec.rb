# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocalesHelper, type: :helper do
  describe '#rtl?' do
    context 'when locale is :ar' do
      before(:each) { I18n.locale = :ar }

      it 'returns true' do
        expect(rtl?).to eq(true)
      end
    end

    context 'when locale is :en' do
      before(:each) { I18n.locale = :en }

      it 'returns true' do
        expect(rtl?).to eq(false)
      end
    end
  end
end
