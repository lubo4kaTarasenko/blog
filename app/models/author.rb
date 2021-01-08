class Author < ApplicationRecord
  has_secure_password

  has_many :posts
  has_many :comments
  has_many :author_comment_votes

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  validates :password, presence: true, length: { minimum: 6, maximum: 50 }, unless: :persisted?
  validates :email, presence: true, length: {
    minimum: 5, maximum: 50
  }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  def full_name
    "#{first_name} #{last_name} "
  end

  after_create :create_token

  private

  def create_token
    token = (0..99).to_a.sample(5).join
    self.token = token
    save
  end
end
