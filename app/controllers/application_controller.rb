class ApplicationController < ActionController::API

  private

  def authorize_account
    if !current_user.present?
      render json: {error: 'Authorization invalid'}
    end
  end

  def current_user
    if token.present?
      decoded = decode(token)
      @current_user ||= User.find_by(id: decoded.first['user_id']) if decoded.present?
    end
  end

  def decode(token)
    JWT.decode(token, ENV['JWT_SECRET'], true, {algorithm: ENV['JWT_ALGORITHM']})
    rescue JWT::DecodeError
      return nil
  end

  def token
    token = request.headers['Authorization']
  end

end
