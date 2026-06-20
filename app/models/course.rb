class Course < ApplicationRecord
  belongs_to :instructor, class_name: "User"
  has_many :lessons, -> { order(position: :asc) }, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user
  has_many :reviews, dependent: :destroy
  has_many :discussion_threads, dependent: :destroy
  has_many :certificates, dependent: :destroy
  belongs_to :category, optional: true

  enum :status, { draft: 0, published: 1, archived: 2 }
  enum :level, { beginner: 0, intermediate: 1, advanced: 2 }

  validates :title, :description, :price, presence: true
  validates :title, length: { maximum: 100 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  has_one_attached :cover_image

  scope :published, -> { where(status: :published) }
  scope :by_category, ->(category) { where(category: category) if category.present? }

  def total_duration
    lessons.sum(:duration)
  end

  def lesson_count
    lessons.count
  end

  def student_count
    enrollments.active.count
  end

  def progress_for(user)
    enrollment = enrollments.find_by(user: user)
    enrollment&.progress || 0
  end

  def average_rating
    reviews.average(:rating)&.round(1) || 0
  end

  def review_count
    reviews.count
  end
end
