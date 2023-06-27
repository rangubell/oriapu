class LeaveApplication < ApplicationRecord
  belongs_to :user
  belongs_to :paid_leave
  belongs_to :updated_by_user, class_name: 'User', foreign_key: 'updated_by_user_id', optional: true
end
