class Api::V1::ActionsController < ApplicationController
  before_action :authorize_account, only: [:complete]

  def complete
    # Bug somewhere here that duplicates actions of plans that repeat
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

  def delete
    action = Action.find(params[:id])
    action.destroy
    # return both the user and the plan. Having trouble serializing the results.
    user = current_user
    plan = action.goal
    binding.pry
    render json: { user: user, plan: action.goal.plan }
  end

  private

  def plan_params
    params.require(:action).permit(:description, :complete, :completed_at, :goal_id)
  end


end
