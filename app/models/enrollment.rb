class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :lesson_progresses, dependent: :destroy
  has_one :certificate, dependent: :destroy

  enum :status, { active: 0, completed: 1, cancelled: 2 }

  validates :user_id, uniqueness: { scope: :course_id, message: "já matriculado neste curso" }

  after_create :create_initial_progresses

  def update_progress!
    total = course.lessons.count
    return if total.zero?
    done = lesson_progresses.where(completed: true).count
    update(progress: (done.to_f / total * 100).round(2))
    if progress >= 100 && active?
      complete_course!
    end
  end

  def issue_certificate!
    return if certificate.present?
    existing = Certificate.where(user: user, course: course)
    return if existing.exists?
    Certificate.create!(user: user, course: course, enrollment: self)
  end

  private

  def complete_course!
    update!(status: :completed, completed_at: Time.current)
    issue_certificate!
  end

  def create_initial_progresses
    course.lessons.each do |lesson|
      lesson_progresses.find_or_create_by!(lesson: lesson)
    end
  end
end
