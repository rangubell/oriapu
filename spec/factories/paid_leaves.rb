FactoryBot.define do
  factory :paid_leave do
    association :user
    total_day { Faker::Number.within(range: 0..30) }
    remaining_day { Faker::Number.within(range: 0..30) }
    granted_date { Faker::Date.between(from: Date.new(2020, 1, 1), to: Date.current) }
  end
end
