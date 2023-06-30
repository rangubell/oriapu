FactoryBot.define do
  factory :user do
    name                  { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    department_id         { Faker::Number.between(from: 2, to: 6) }
    hired_date            { Faker::Date.between(from: 10.years.ago, to: Date.today) }
  end
end
