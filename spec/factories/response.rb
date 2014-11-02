FactoryGirl.define do
  factory :response do
    user
    conversation
    body { Faker::Lorem.paragraph }
  end
end
