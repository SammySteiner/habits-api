class Api::V1::PlansController < ApplicationController
  before_action :authorize_account, only: [:create]

  def create
    user = current_user
    plan = Plan.create(title: plan_params[:title], description: plan_params[:description], repeat: plan_params[:repeat], user_id: user.id)
    plan_params[:goals].each do |goal|
      binding.pry
      new_goal = Goal.create( expiration: Date.today + goal[:expiration].to_i, plan_id: plan.id)
      goal[:actions].each do |action|
        binding.pry
        Action.create(description: action, goal_id: new_goal.id)
      end
    end
    render json: plan
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :description, :repeat, goals: [:expiration, actions: []])
  end


end
