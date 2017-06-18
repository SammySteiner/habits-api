class Goal < ApplicationRecord
  belongs_to :plan
  has_many :actions, dependent: :destroy

  def completed_actions
    completed = 0
    actions.each do |action|
      if action.complete
        completed += 1
      end
    end
    completed
  end

  def actions_attributes=(actions)
    actions.each do |action_attributes|
      self.actions.build(action_attributes)
    end
  end

  def start_date
    total_days = 0
    self.plan.goals.each do |g|
      break if self == g
      total_days += g.interval
    end
    self.plan.created_at + total_days.days
  end

  def expiration
    self.start_date + interval.days
  end

  def complete
    completed_actions = 0
    self.actions.each do |action|
      if action.complete
        completed_actions += 1
      end
    end
    completed_actions === self.actions.count
  end


end
