class Comment < ApplicationRecord
  belongs_to :post, required: true, counter_cache: true
  belongs_to :author, required: true

  enum status: %i[unpublished published]

  validates :body, presence: true
  validates :body, length: { minimum: 5 }

  # scope :published,   -> { where(status: :published) }
  # scope :unpublished,   -> { where(status: :unpublished) }
end
