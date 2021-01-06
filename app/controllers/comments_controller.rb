class CommentsController < ApplicationController

  before_action :init_post
  before_action :init_comment, only: %i[destroy update]

  def create
    @comment = @post.comments.create(comment_params.merge(author_id: current_author.id))
    message = if @comment.persisted?
                { notice: 'Commented created successfully' }
              else
                { alert: 'Comment was not created. Make sure your comment is not less then 5 chars and it is not to deep' }
              end
    redirect_to post_path(@post), message
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: 'Comment was successfully updated.'
    else
      redirect_to post_path(@post)
    end
  end

 # def publish
    #@post = Post.find(params[:post_id])
    #@comment = @post.comments.find(params[:id])
    #@comment.update(status: :published)
    #redirect_to post_path(@post), notice: 'Comment was successfully published.'
  #end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def init_post
    @post = Post.find(params[:post_id])
  end

  def init_comment
    @comment = @post.comments.where(author_id: current_author.id).find(params[:id])
  end
end
