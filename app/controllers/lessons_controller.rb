class LessonsController < ApplicationController
  before_action :set_course
  before_action :set_lesson, only: [:show]
  before_action :ensure_enrolled, only: [:show]

  def show
    @enrollment = current_user.enrollments.find_by(course: @course)
    @progress = @enrollment.lesson_progresses.find_by(lesson: @lesson)
    @lessons = @course.lessons.ordered
  end

  def complete
    @lesson = @course.lessons.find(params[:lesson_id])
    @enrollment = current_user.enrollments.find_by(course: @course)
    @progress = @enrollment.lesson_progresses.find_by(lesson: @lesson)
    @progress.update!(completed: true, completed_at: Time.current)

    if @lesson.next_lesson
      redirect_to course_lesson_path(@course, @lesson.next_lesson),
                  notice: "Aula concluída!"
    else
      redirect_to course_path(@course),
                  notice: "Parabéns! Você concluiu o curso!"
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lesson
    @lesson = @course.lessons.find(params[:id])
  end

  def ensure_enrolled
    unless current_user.enrolled_in?(@course) || @lesson.free_preview
      redirect_to course_path(@course), alert: "Matricule-se para acessar as aulas."
    end
  end
end
