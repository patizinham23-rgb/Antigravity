class DiscussionReply < ApplicationRecord
  belongs_to :discussion_thread, counter_cache: true
  belongs_to :user

  validates :body, presence: true

  after_create :update_thread_activity

  private

  def update_thread_activity
    discussion_thread.touch
  end
end
