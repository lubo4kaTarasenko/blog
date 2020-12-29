class Post < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_rich_text :content

  validates :name, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :title, length: { maximum: 20, message: 'is too long' }
end
