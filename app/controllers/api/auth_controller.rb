class Api::AuthController < ActionController::API

  def sign_up
    json = params.permit(:email, :password)
    json = JSON.parse(request.body.read).symbolize_keys if json.empty?

    user = Author.create(email: json[:email], password: json[:password])

    if user.errors.present?
      render json: { error: user.errors.full_messages} 
    else
      render json: { token: user.token }
    end
  end

  def log_in
    json = params.permit(:email, :password)
    json = JSON.parse(request.body.read).symbolize_keys if json.empty?

    user = Author.find_by(email: json[:email])

    if user&.authenticate(json[:password])
      render json: { token: user.token }
    else
      render json: { error: 'invalid email or password' }
    end
  end
end