class Comment < ApplicationRecord
  belongs_to :post, required: true, counter_cache: true
  belongs_to :author, required: true
  has_many :author_comment_votes
  has_ancestry

  enum status: %i[unpublished published]

  validates :body, presence: true
  validates :body, length: { minimum: 5 }
  validates_with Validators::DepthValidator 


  def count_likes
    self.author_comment_votes.liked.count
  end

  def count_dislikes
    self.author_comment_votes.disliked.count
  end

end
