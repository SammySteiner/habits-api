class GoalSerializer < ActiveModel::Serializer
  attributes :id, :expiration, :complete, :completed_at
  has_many :actions
end
