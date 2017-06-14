class GoalSerializer < ActiveModel::Serializer
  attributes :id, :expiration, :complete, :completed_at, :interval, :start_date
  has_many :actions
end
