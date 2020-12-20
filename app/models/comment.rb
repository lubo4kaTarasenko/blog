class Comment < ApplicationRecord
  belongs_to :post, required: true
  belongs_to :author, required: true

  enum status: [ :unpublished, :published ]

  validates :body, presence: true, length: { minimum: 5 }

  #scope :published,   -> { where(status: :published) }
  #scope :unpublished,   -> { where(status: :unpublished) }
end
