class Lesson < ApplicationRecord
  belongs_to :course, touch: true
  has_many :lesson_progresses, dependent: :destroy

  validates :title, presence: true
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :free_preview, -> { where(free_preview: true) }
  scope :ordered, -> { order(position: :asc) }

  def completed_by?(user)
    lesson_progresses.joins(:enrollment)
      .where(enrollments: { user_id: user.id }, completed: true).exists?
  end

  def next_lesson
    course.lessons.where("position > ?", position).ordered.first
  end

  def prev_lesson
    course.lessons.where("position < ?", position).ordered.last
  end

  def move_higher
    swap_position_with(:prev_lesson)
  end

  def move_lower
    swap_position_with(:next_lesson)
  end

  private

  def swap_position_with(sibling_method)
    sibling = send(sibling_method)
    return unless sibling

    my_pos = position
    sibling_pos = sibling.position

    transaction do
      update!(position: sibling_pos)
      sibling.update!(position: my_pos)
    end
  end
end
