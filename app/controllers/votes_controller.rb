class VotesController < ApplicationController
  def vote
    vote_params = permitted_vote_params.merge(author_id: current_author.id)
    @vote = AuthorCommentVote.find_by(vote_params.except(:positive))
  
    if @vote.present?     
      is_identical = @vote.positive?.to_s ==  vote_params[:positive]  
      @vote.destroy   
      AuthorCommentVote.create(vote_params) unless is_identical
    else
       AuthorCommentVote.create(vote_params)
    end
  end

  private

  def permitted_vote_params
    params.permit(:comment_id, :positive)
  end
end