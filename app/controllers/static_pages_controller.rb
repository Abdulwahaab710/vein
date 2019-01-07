# frozen_string_literal: true

class StaticPagesController < ApplicationController
  skip_before_action :user_logged_in?, only: :index
  skip_before_action :user_confirmed?, only: :index

  def index
    @body_gradient_background = true
    @transparent = true

    render :index
  end
end
