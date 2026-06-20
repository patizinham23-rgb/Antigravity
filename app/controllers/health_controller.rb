class HealthController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    render json: { status: "ok", time: Time.current }
  end
end
