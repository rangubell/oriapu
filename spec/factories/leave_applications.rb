FactoryBot.define do
  factory :leave_application do
    association :user
    association :paid_leave
    start_date { Faker::Date.between(from: Date.today, to: Date.today + 1.month) }
    end_date { Faker::Date.between(from: start_date, to: start_date + 1.weeks) }
    reason { Faker::Lorem.sentence }
    status { "承認" }
  end
end
