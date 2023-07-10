class LeaveApplication < ApplicationRecord
  belongs_to :user
  belongs_to :paid_leave
  belongs_to :updated_by_user, class_name: 'User', optional: true

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :reason, presence: true
  validates :status, presence: true

  validate :end_date_after_start_date

  def end_date_after_start_date
    return unless end_date && start_date && end_date < start_date
  
    errors.add(:end_date, 'must be after start date')
  end

  def consume_leave_days
    leave_days = (end_date.to_date - start_date.to_date).to_i + 1
    user.paid_leave.remaining_day -= leave_days
    user.paid_leave.save!
  end

  def status_approved?
    status == '承認'
  end
end
