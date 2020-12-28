class AuthorsController < ApplicationController

  def new
    @author = Author.new
  end

  def create
    @author = Author.create(params.require(:author).permit(:email, :password))
    session[:author_id] = @author.id
    if @author.valid?
      redirect_to :root
    else
      redirect_to '/authors/new', alert: 'Invalid email or password'
    end
  end
end