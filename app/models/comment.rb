class Comment < ApplicationRecord
  belongs_to :post
  enum status: [ :published, :unpublished ]
end
