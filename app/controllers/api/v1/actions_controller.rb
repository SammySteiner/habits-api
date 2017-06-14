class Api::V1::ActionsController < ApplicationController
  before_action :authorize_account, only: [:complete]

  def complete
    action = Action.find(params[:id])
    complete = action.complete ? false : true
    date = Date.today()
    action.update(complete: complete, completed_at: date)
    goal = action.goal
    plan = goal.plan
    conditions = action.goal.actions.count
    completed = 0
    goal.actions.each do |action|
      if action.complete
        completed += 1
      end
    end
    if conditions === completed
      goal.update(complete: true, completed_at: date)
      completed_goals = 0
      plan.goals.each do |plan_goal|
        if plan_goal.complete
          completed_goals += 1
        end
      end
      if plan.goals.count === completed_goals
        if plan.repeat
          plan.goals.each_with_index do |repeat_goal, index|
          new_start_date = index === 0 ? goal.expiration : plan.goals[-1].expiration
          new_expiration = new_start_date + repeat_goal.interval
          new_goal = Goal.create(interval: repeat_goal.interval, expiration: new_expiration, start_date: new_start_date, plan_id: plan.id)
            repeat_goal.actions.each do |repeat_action|
              Action.create(description: repeat_action.description, goal_id: repeat_goal.id)
            end
          end
        else
          goal.plan.update(complete: true, completed_at: Date.today())
        end
      end
    end
    render json: current_user
  end

  private

  def plan_params
    params.require(:action).permit(:description, :complete, :completed_at, :goal_id)
  end


end
