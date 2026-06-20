class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @featured_courses = Course.published.includes(:instructor).limit(6)
    @course_count = Course.published.count
    @student_count = Enrollment.active.count
  end
end
