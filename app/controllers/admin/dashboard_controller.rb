class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @total_users = User.count
    @total_courses = Course.count
    @total_enrollments = Enrollment.active.count
    @total_revenue = Enrollment.active.joins(:course).sum(:price)
    @recent_enrollments = Enrollment.includes(:user, :course).order(created_at: :desc).limit(10)
  end

  private

  def require_admin
    redirect_to root_path, alert: "Acesso restrito." unless current_user.admin?
  end
end
