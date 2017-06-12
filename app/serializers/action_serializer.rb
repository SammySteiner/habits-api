class ActionSerializer < ActiveModel::Serializer
  attributes :id, :description, :complete, :completed_at
end
