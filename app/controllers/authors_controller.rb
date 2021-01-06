class AuthorsController < ApplicationController
  def new
    @author = Author.new
  end

  def create
    @author = Author.create(author_auth_params)
    session[:author_id] = @author.id
    if @author.valid?
      redirect_to :root
    else
      redirect_to '/authors/new', alert: 'Invalid email or password'
    end
  end

  def profile
    @author = current_author
  end

  def save_profile
    current_author.update(author_params)
    redirect_to profile_authors_path
  end

  private

  def author_params
    params.require(:author).permit(:avatar, :first_name, :last_name)
  end

  def author_auth_params
    params.require(:author).permit(:email, :password)
  end
end
