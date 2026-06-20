class DiscussionThreadsController < ApplicationController
  before_action :set_course
  before_action :ensure_enrolled, except: [:index, :show]

  def index
    @threads = @course.discussion_threads.pinned_first.includes(:user, :discussion_replies)
    @thread = @course.discussion_threads.new
  end

  def show
    @thread = @course.discussion_threads.find(params[:id])
    @replies = @thread.discussion_replies.includes(:user).order(created_at: :asc)
    @reply = @thread.discussion_replies.new
  end

  def new
    @thread = @course.discussion_threads.new
    @thread.lesson_id = params[:lesson_id] if params[:lesson_id]
  end

  def create
    @thread = @course.discussion_threads.new(thread_params)
    @thread.user = current_user

    if @thread.save
      redirect_to [@course, @thread], notice: "Tópico criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def ensure_enrolled
    unless current_user&.enrolled_in?(@course)
      redirect_to @course, alert: "Matricule-se para participar das discussões."
    end
  end

  def thread_params
    params.require(:discussion_thread).permit(:title, :body, :lesson_id)
  end
end
