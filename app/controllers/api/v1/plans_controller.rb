class Api::V1::PlansController < ApplicationController
  before_action :authorize_account, only: [:create]

  def create
    user = current_user
    today = Date.today
    date = Date.today
    plan = Plan.create(title: plan_params[:title].titleize, description: plan_params[:description], repeat: plan_params[:repeat], user_id: user.id)
    plan_params[:goals].each do |goal|
      date = date + goal[:interval].to_i
      binding.pry
      # set a start date with current date plus interval
      # save the interval, save the start date as today

      new_goal = Goal.create( expiration: date, plan_id: plan.id, interval: goal[:interval].to_i, start_date: today)
      goal[:actions].each do |action|
        Action.create(description: action[:description], goal_id: new_goal.id)
      end
    end
    render json: plan
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :description, :repeat, goals: [:interval, actions: [:description]])
  end


end
