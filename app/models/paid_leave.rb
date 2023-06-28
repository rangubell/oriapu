class PaidLeave < ApplicationRecord
  belongs_to :user

  def self.grant_annual_leave_if_due
    paid_leaves = PaidLeave.includes(:user).where('granted_date < ?', Date.current)
  
    paid_leaves.each do |paid_leave|
      if paid_leave.granted_date <= Date.current
        new_total_day = paid_leave.total_day + 10
        new_remaining_day = paid_leave.remaining_day + 10
  
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