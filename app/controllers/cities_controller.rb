# frozen_string_literal: true

class CitiesController < ApplicationController
  def show
    city = City.find(params[:id])
    districts = if I18n.locale == :en
                  city&.districts&.select(:id, :name)
                else
                  city&.districts&.select(:id, 'ar_name as name')
                end

    render json: districts.as_json
  end
end
