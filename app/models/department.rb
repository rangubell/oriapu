class Department < ApplicationRecord

  validates :name, presence: true

  has_many :schedules
  has_many :paid_leaves
  belongs_to :department
end