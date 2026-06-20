class Instructor::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_instructor

  def index
    @courses = current_user.courses.includes(:enrollments)
    @total_students = @courses.joins(:enrollments).merge(Enrollment.active).count
    @total_revenue = @courses.joins(:enrollments).merge(Enrollment.active).sum(:price)
  end

  private

  def require_instructor
    redirect_to root_path, alert: "Acesso restrito." unless current_user.instructor?
  end
end
