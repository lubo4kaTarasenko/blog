class UniqueColumnsInAuthorCommentVote < ActiveRecord::Migration[6.1]
  def change
    add_index :author_comment_votes, [:author_id, :comment_id], unique: true
  end
end
