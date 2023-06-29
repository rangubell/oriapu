every '0 0 1 * *' do
  runner 'PaidLeave.grant_annual_leave_if_due'
end
