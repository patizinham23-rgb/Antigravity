class DiscussionThread < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :lesson, optional: true
  has_many :discussion_replies, dependent: :destroy

  validates :title, :body, presence: true

  scope :pinned_first, -> { order(pinned: :desc, created_at: :desc) }
  scope :general, -> { where(lesson_id: nil) }
  scope :for_lesson, ->(lesson_id) { where(lesson_id: lesson_id) }

  def reply_count
    discussion_replies.count
  end

  def last_activity
    discussion_replies.maximum(:created_at) || created_at
  end
end
