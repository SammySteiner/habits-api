class User < ApplicationRecord
  has_secure_password
  has_many :plans
  has_many :comments, through: :plans
  has_many :ratings, through: :plans
  has_many :goals, through: :plans
  has_many :actions, through: :goals
end
