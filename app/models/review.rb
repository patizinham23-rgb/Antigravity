class Review < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :course_id, message: "já avaliou este curso" }

  after_save :update_course_rating
  after_destroy :update_course_rating

  scope :recent, -> { order(created_at: :desc) }

  private

  def update_course_rating
    # Trigger cache update or recompute
  end
end
