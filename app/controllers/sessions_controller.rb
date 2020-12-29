class SessionsController < ApplicationController
  def new; end

  def create
    @author = Author.find_by(email: params[:email])
    if @author && @author.authenticate(params[:password])
      session[:author_id] = @author.id
      Rails.logger.info 'authorize'
      redirect_to :root
    else
      Rails.logger.info 'Invalid'
      redirect_to login_path, alert: 'Invalid email or password'
    end
  end

  def destroy
    session[:author_id] = nil
    redirect_to :root
  end
end
