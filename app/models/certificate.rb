class Certificate < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :enrollment

  validates :code, presence: true, uniqueness: true
  validates :user_id, uniqueness: { scope: :course_id }

  before_validation :generate_code, on: :create

  scope :recent, -> { order(issued_at: :desc) }

  def full_code
    "ANTI-#{code}"
  end

  private

  def generate_code
    loop do
      self.code = SecureRandom.alphanumeric(12).upcase
      break unless Certificate.exists?(code: code)
    end
  end
end
