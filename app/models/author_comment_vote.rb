class AuthorCommentVote < ApplicationRecord
  belongs_to :comment
  belongs_to :author
 
  scope :liked, -> {where(positive: true)}
  scope :disliked, -> {where(positive: false)}
end