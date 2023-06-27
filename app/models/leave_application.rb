class LeaveApplication < ApplicationRecord
  belongs_to :user
  belongs_to :paid_leave
  belongs_to :updated_by_user, class_name: 'User', foreign_key: 'updated_by_user_id', optional: true

  def consume_leave_days
    leave_days = (end_date.to_date - start_date.to_date).to_i + 1
    user.paid_leave.remaining_day -= leave_days
    user.paid_leave.save!
  end  

  def status_approved?
    status == '承認'
  end
end
