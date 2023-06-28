class PaidLeave < ApplicationRecord
  belongs_to :user

  def self.grant_annual_leave_if_due
    paid_leaves = PaidLeave.includes(:user).where('granted_date < ?', Date.current)

    paid_leaves.each do |paid_leave|
      if (paid_leave.granted_date + 1.year) <= Date.current
        years_since_granted = ((Date.current - paid_leave.granted_date) / 1.year).to_i
        new_total_day = 10 + years_since_granted
        new_remaining_day = 10 + years_since_granted

        # 有給情報を更新する
        paid_leave.update(
          total_day: new_total_day,
          remaining_day: new_remaining_day,
          granted_date: paid_leave.granted_date + 1.year
        )
      end
    end
  end
end