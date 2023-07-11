require 'clockwork'

module Clockwork
  handler do |job|
    puts "Running #{job}"
    if job == 'PaidLeave.grant_annual_leave_if_due'
      PaidLeave.grant_annual_leave_if_due
    end
  end

  every(1.month, 'PaidLeave.grant_annual_leave_if_due', at: '00:00', tz: 'Asia/Tokyo') do
    PaidLeave.grant_annual_leave_if_due
  end  
end
