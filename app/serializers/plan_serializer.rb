class PlanSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :repeat, :complete, :completed_at
  has_many :goals


end
