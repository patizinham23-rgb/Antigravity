class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_pagy

  private

  def set_pagy
    @pagy, @records = nil, nil
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    elsif resource.instructor?
      instructor_dashboard_path
    else
      dashboard_path
    end
  end
end
