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
    if conditions === goal.completed_actions
      goal.update(complete: true, completed_at: date)
      if plan.goals.count === plan.completed_goals
        if plan.repeat
          plan.repeat_plan(goal)
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
