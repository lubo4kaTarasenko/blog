class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    message = if @comment.persisted?
                { notice: 'Commented created successfully' }
              else
                { alert: 'Comment was not created. Make sure your comment is not less then 5 chars' }
              end
    redirect_to post_path(@post), message
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: 'Comment was successfully updated.'
    else
      redirect_to post_path(@post)
    end
  end

  def publish
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.update(status: :published)
    redirect_to post_path(@post), notice: 'Comment was successfully published.'
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :author_id)
  end
end
