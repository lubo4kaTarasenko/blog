class Api::PostsController < ActionController::API
  def index
    posts =  Post.all.includes(:author).map do |p| 
      p.attributes.merge(
        text: (p.text[0..500] + '...'),
        author: p.author.email
      ) 
    end
    render json: { posts: posts }
  end

  def create
    json = params.permit(:name, :title, :content, :image)
    json = JSON.parse(request.body.read).symbolize_keys if json.empty?

    user_id = Author.find_by(token: params[:token]).id

    post = Post.create(json.merge(author_id: user_id))
  
    render json: { post: post.attributes }
  end

 def update
    json = params.permit(:id, :text, :check, :color)
    json = JSON.parse(request.body.read).symbolize_keys if json.empty?

    result = Item.where(token: params[:token], id: params[:id] || json[:id]).update_all(json.to_h)
    render json: { result: result }
  end

  def destroy
    result = Item.where(token: params[:token], id: params[:id]).delete_all
    render json: { result: result }
  end
end