class DashboardController < ApplicationController
  def index
    @enrollments = current_user.enrollments.active.includes(course: :instructor)
    @in_progress = @enrollments.where.not(progress: 100)
    @completed = current_user.enrollments.completed.includes(course: :instructor)
  end
end
