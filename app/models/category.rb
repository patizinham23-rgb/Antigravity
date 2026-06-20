class Category < ApplicationRecord
  has_many :courses, dependent: :nullify

  validates :name, :slug, presence: true
  validates :name, :slug, uniqueness: true

  before_validation :generate_slug, on: :create

  scope :with_courses, -> { joins(:courses).where(courses: { status: :published }).distinct }

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug ||= name.parameterize
  end
end
