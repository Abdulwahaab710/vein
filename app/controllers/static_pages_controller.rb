# frozen_string_literal: true

class StaticPagesController < ApplicationController
  skip_before_action :user_logged_in?, only: :index
  skip_before_action :user_confirmed?, only: :index

  layout false

  def index
    render :index, layout: 'application_with_transparent_header'
  end
end
