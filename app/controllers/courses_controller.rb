class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :enroll]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @courses = Course.published.includes(:instructor).order(created_at: :desc)
    @courses = @courses.by_category(params[:category]) if params[:category].present?
    @pagy, @courses = pagy(@courses, items: 12)
  end

  def show
    @lessons = @course.lessons.ordered
    @enrolled = current_user&.enrolled_in?(@course)
    @enrollment = current_user&.enrollments&.find_by(course: @course)
  end

  def enroll
    if current_user.enrolled_in?(@course)
      redirect_to course_path(@course), notice: "Você já está matriculado."
    else
      @enrollment = current_user.enrollments.create!(course: @course)
      redirect_to course_lesson_path(@course, @course.lessons.first),
                  notice: "Matrícula realizada com sucesso!"
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
