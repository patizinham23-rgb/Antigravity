class DiscussionRepliesController < ApplicationController
  before_action :set_course
  before_action :set_thread
  before_action :ensure_enrolled

  def create
    @reply = @thread.discussion_replies.new(reply_params)
    @reply.user = current_user

    if @reply.save
      redirect_to [@course, @thread], notice: "Resposta publicada!"
    else
      redirect_to [@course, @thread], alert: @reply.errors.full_messages.to_sentence
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_thread
    @thread = @course.discussion_threads.find(params[:discussion_thread_id])
  end

  def ensure_enrolled
    unless current_user&.enrolled_in?(@course)
      redirect_to @course, alert: "Matricule-se para participar das discussões."
    end
  end

  def reply_params
    params.require(:discussion_reply).permit(:body)
  end
end
