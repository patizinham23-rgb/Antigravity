class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_instructor
  before_action :set_course

  def index
    @lessons = @course.lessons.ordered
  end

  def new
    @lesson = @course.lessons.build
  end

  def create
    @lesson = @course.lessons.build(lesson_params)
    @lesson.position = @course.lessons.count
    if @lesson.save
      redirect_to instructor_course_lessons_path(@course), notice: "Aula criada."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @lesson = @course.lessons.find(params[:id])
  end

  def update
    @lesson = @course.lessons.find(params[:id])
    if @lesson.update(lesson_params)
      redirect_to instructor_course_lessons_path(@course), notice: "Aula atualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson = @course.lessons.find(params[:id])
    @lesson.destroy
    redirect_to instructor_course_lessons_path(@course), notice: "Aula removida."
  end

  def move_up
    @lesson = @course.lessons.find(params[:id])
    @lesson.move_higher
    redirect_to instructor_course_lessons_path(@course), notice: "Aula reordenada."
  end

  def move_down
    @lesson = @course.lessons.find(params[:id])
    @lesson.move_lower
    redirect_to instructor_course_lessons_path(@course), notice: "Aula reordenada."
  end

  private

  def set_course
    @course = current_user.courses.find(params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :content, :video_url, :duration, :free_preview)
  end

  def require_instructor
    redirect_to root_path, alert: "Acesso restrito." unless current_user.instructor?
  end
end
