class PaidLeave < ApplicationRecord
  belongs_to :user
  has_many :leave_applications

  MAX_GRANT_DAYS = 20

  validates :total_day, numericality: { greater_than_or_equal_to: 0 }
  validates :remaining_day, numericality: { greater_than_or_equal_to: 0 }

  def self.grant_annual_leave_if_due
    paid_leaves = PaidLeave.includes(:user).where('granted_date < ?', Date.current)
  
    paid_leaves.each do |paid_leave|
      if paid_leave.granted_date <= Date.current
        user_hired_date = paid_leave.user.hired_date
        years_since_hired = (Date.current.year - user_hired_date.year)
        additional_days = [MAX_GRANT_DAYS, 10 + years_since_hired].min
        new_total_day = paid_leave.total_day + additional_days
        new_remaining_day = paid_leave.remaining_day + additional_days
  
        # 有給情報を更新する
        paid_leave.update(
          total_day: new_total_day,
          remaining_day: new_remaining_day,
          granted_date: Date.current + 1.year
        )
      end
    end
  end
end
