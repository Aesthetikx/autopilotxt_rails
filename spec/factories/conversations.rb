FactoryGirl.define do
  factory :conversation do
    user
    expires_at { Time.now + 3.minutes }
  end
end
