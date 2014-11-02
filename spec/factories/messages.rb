# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    conversation
    body { Faker::Lorem.paragraph }
    time { Time.now }
    source { [0, 1, 2].sample }
  end
end
