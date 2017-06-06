class Goal < ApplicationRecord
  belongs_to :plan
  has_many :actions
end
