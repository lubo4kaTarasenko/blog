class Comment < ApplicationRecord
  belongs_to :post, required: true
  belongs_to :author, required: true
  enum status: [ :published, :unpublished ]
  validates :body, length: { minimum: 5 }
end
