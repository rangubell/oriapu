class Schedule < ApplicationRecord
  belongs_to :user
  has_many :shared_schedules
  has_many :shared_users, through: :shared_schedules, source: :user
end
