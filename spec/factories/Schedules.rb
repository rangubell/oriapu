FactoryBot.define do
  factory :schedule do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    user
  end
end
