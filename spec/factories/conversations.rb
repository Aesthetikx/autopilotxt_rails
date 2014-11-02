FactoryGirl.define do
  factory :conversation do
    expires_at { Time.now + 3.minutes }
  end
end
