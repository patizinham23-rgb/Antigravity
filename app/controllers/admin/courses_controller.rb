class Admin::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @courses = Course.includes(:instructor, :enrollments).order(created_at: :desc)
    @pagy, @courses = pagy(@courses)
  end

  def show
    @course = Course.find(params[:id])
    @enrollments = @course.enrollments.includes(:user)
  end

  private

  def require_admin
    redirect_to root_path, alert: "Acesso restrito." unless current_user.admin?
  end
end
