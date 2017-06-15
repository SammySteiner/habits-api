class Api::V1::GoalsController < ApplicationController
  before_action :authorize_account, only: [:delete]

  def delete
    goal = Goal.find(params[:id])
    goal.destroy
    render json: current_user
  end

end
