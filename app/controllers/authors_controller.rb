class AuthorsController < ApplicationController

  def new
    @author = Author.new
  end

  def create
    @author = Author.create(params.require(:author).permit(:email, :password))
    session[:author_id] = @author.id
    redirect_to :root
  end
end