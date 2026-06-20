class ReviewsController < ApplicationController
  before_action :set_course
  before_action :ensure_enrolled, only: [:create]

  def create
    @review = @course.reviews.find_or_initialize_by(user: current_user)
    @review.assign_attributes(review_params)

    if @review.save
      redirect_to @course, notice: "Avaliação salva com sucesso!"
    else
      redirect_to @course, alert: @review.errors.full_messages.to_sentence
    end
  end

  def update
    @review = @course.reviews.find_by(user: current_user)
    if @review&.update(review_params)
      redirect_to @course, notice: "Avaliação atualizada!"
    else
      redirect_to @course, alert: "Não foi possível atualizar sua avaliação."
    end
  end

  def destroy
    @review = @course.reviews.find_by(user: current_user)
    @review&.destroy
    redirect_to @course, notice: "Avaliação removida."
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def ensure_enrolled
    unless current_user&.enrolled_in?(@course)
      redirect_to @course, alert: "Você precisa estar matriculado para avaliar."
    end
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
