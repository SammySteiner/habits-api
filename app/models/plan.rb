class Plan < ApplicationRecord
  belongs_to :user
  has_many :goals, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy

  def completed_goals
    completed_goals = 0
    goals.each do |plan_goal|
      if plan_goal.complete
        completed_goals += 1
      end
    end
    completed_goals
  end

  def repeat_plan(goal)
    goals.each_with_index do |repeat_goal, index|
      new_start_date = index === 0 ? goal.expiration : plan.goals[-1].expiration
      new_expiration = new_start_date + repeat_goal.interval
      new_goal = Goal.create(interval: repeat_goal.interval, expiration: new_expiration, start_date: new_start_date, plan_id: self.id)
      repeat_goal.actions.each do |repeat_action|
          Action.create(description: repeat_action.description, goal_id: repeat_goal.id)
        end
      end
  end


end
