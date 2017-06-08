class Plan < ApplicationRecord
  belongs_to :user
  has_many :goals
  has_many :ratings
  has_many :comments
end
