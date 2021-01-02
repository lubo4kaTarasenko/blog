class PostsController < ApplicationController
  before_action :set_public_post, only: %i[show]
  before_action :set_author_post, only: %i[edit update destroy]
  before_action :add_view, only: %i[index show]

  def add_view
    unless current_author
      cookies[:views] = cookies[:views].present? ? cookies[:views].to_i + 1 : 1 
      @show_register = cookies[:views].to_i % 5 == 0
    end
  end

  def index
    @posts = Post.search(params[:q]).page params[:page]
  end

  def show
    @comment_status = params[:comments_status].to_s.downcase

    @comments = if @comment_status == 'unpublished'
                  @post.comments.unpublished
                else
                  @post.comments.published
                end

    # @post.update_columns(views_count: @post.views_count.to_i.succ)
    @post.increment!(:views_count)
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params.merge(author_id: current_author.id))
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def set_public_post
    @post = Post.find(params[:id])
  end

  def set_author_post
    @post = Post.where(author_id: current_author.id).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :title, :content, :image)
  end
end
