class PaidLeave < ApplicationRecord
  belongs_to :user
  has_many :leave_applications
end