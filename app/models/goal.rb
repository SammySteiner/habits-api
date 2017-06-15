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



end
