# frozen_string_literal: true

class CitiesController < ApplicationController
  def show
    city = City.find(params[:id])
    districts = city&.districts&.select(:id, :name)

    render json: districts.as_json
  end
end
