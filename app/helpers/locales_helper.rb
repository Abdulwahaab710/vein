# frozen_string_literal: true

module LocalesHelper
  def rtl?
    I18n.locale == :ar
  end
end
