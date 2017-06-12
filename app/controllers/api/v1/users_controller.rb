class Api::V1::UsersController < ApplicationController
  before_action :authorize_account, only: [:index, :show, :update, :destroy]

  def index
    users = User.all
    render json: users
  end

  def create
    user = User.create(user_params)
    token = JWT.encode({user_id: user.id}, ENV['JWT_SECRET'], ENV['JWT_ALGORITHM'])
    render json: {
      user: user,
      token: token
    }
  end

  def show
    render json: current_user
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
end
