class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { student: 0, instructor: 1, admin: 2 }

  has_many :courses, foreign_key: :instructor_id, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :reviews, dependent: :destroy
  has_many :discussion_threads, dependent: :destroy
  has_many :discussion_replies, dependent: :destroy
  has_many :certificates, dependent: :destroy

  has_one_attached :avatar

  validates :name, presence: true

  scope :students, -> { where(role: :student) }
  scope :instructors, -> { where(role: :instructor) }

  def instructor?
    role == "instructor" || admin?
  end

  def admin?
    role == "admin"
  end

  after_create :send_welcome_email, if: :student?

  def enrolled_in?(course)
    enrollments.where(course: course, status: :active).exists?
  end

  def avatar_url
    avatar.attached? ? avatar : nil
  end

  private

  def send_welcome_email
    NotificationMailer.welcome(self).deliver_later
  end
end
