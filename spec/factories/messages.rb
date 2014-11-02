# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    body { Faker::Lorem.paragraph }
    time { Time.now }
  end
end
