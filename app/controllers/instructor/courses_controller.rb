class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_instructor

  def index
    @courses = current_user.courses.includes(:lessons, :enrollments).order(created_at: :desc)
  end

  def new
    @course = current_user.courses.build
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      redirect_to instructor_courses_path, notice: "Curso criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @course = current_user.courses.find(params[:id])
  end

  def update
    @course = current_user.courses.find(params[:id])
    if @course.update(course_params)
      redirect_to instructor_courses_path, notice: "Curso atualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course = current_user.courses.find(params[:id])
    @course.destroy
    redirect_to instructor_courses_path, notice: "Curso removido."
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :short_description, :price, :category, :level, :status, :cover_image)
  end

  def require_instructor
    redirect_to root_path, alert: "Acesso restrito." unless current_user.instructor?
  end
end
