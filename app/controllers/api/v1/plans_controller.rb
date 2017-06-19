class Api::V1::PlansController < ApplicationController
  before_action :authorize_account, only: [:create, :update, :delete]

  def create
    user = current_user
    Plan.create(plan_params.merge(user_id: current_user.id))
    render json: current_user
  end

  def update
    plan = Plan.find(params[:id])
    plan.update(title: params[:plan][:title], description: params[:plan][:description], repeat: params[:plan][:repeat])
    updated_goals = []
    plan_params[:goals_attributes].each do |g|
      updated_goals << g[:id]
      if Goal.exists?(g[:id])
        goal = Goal.find(g[:id])
        goal.update(interval: g[:interval], complete: g[:complete], completed_at: g[:completed_at])
        g[:actions_attributes].each do |a|
          if Action.exists?(a[:id])
            action = Action.find(a[:id])
            action.update(description: a[:description], complete: a[:complete], completed_at: a[:completed_at])
          else
            Action.create(a.merge(goal_id: g[:id]))
          end
        end
      else
        goal = Goal.create(g.merge(plan_id: plan[:id]))
        updated_goals << goal[:id]
      end
    end
    plan.goals.each do |g|
      if !updated_goals.include?(g[:id])
        g.destroy
      end
    end
    render json: current_user
  end

  def delete
    plan = Plan.find(params[:id])
    plan.destroy
    render json: current_user
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :description, :repeat, :id, :complete, :completed_at, goals_attributes: [:id, :interval, :complete, :completed_at, actions_attributes: [:id, :description, :complete, :completed_at]])
  end

end
