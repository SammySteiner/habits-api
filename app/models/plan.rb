class Plan < ApplicationRecord
  belongs_to :user
  has_many :goals, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  default_scope { order(created_at: :asc) }

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
    new_goal = Goal.create(interval: goal.interval, plan_id: self.id)
    goal.actions.each do |repeat_action|
      Action.create(description: repeat_action.description, goal_id: new_goal.id)
    end
  end

  def goals_attributes=(goals)
    goals.each do |goal_attributes|
      self.goals.build(goal_attributes)
    end
  end

  def complete
    completed_goals = 0
    self.goals.each do |goal|
      if goal.complete
        completed_goals += 1
      end
    end
    completed_goals === self.goals.count
  end


end
