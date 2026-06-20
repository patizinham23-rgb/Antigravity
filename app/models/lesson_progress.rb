class LessonProgress < ApplicationRecord
  belongs_to :enrollment
  belongs_to :lesson

  validates :lesson_id, uniqueness: { scope: :enrollment_id }

  after_save :update_enrollment_progress, if: :saved_change_to_completed?

  private

  def update_enrollment_progress
    enrollment.update_progress!
  end
end
