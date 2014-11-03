FactoryGirl.define do
  factory :response do
    user
    conversation
    body { Faker::Lorem.paragraph }

    factory :response_with_votes do
      ignore do
        upvotes 0
        downvotes 0
      end

      after(:create) do |response, evaluator|
        evaluator.upvotes.times do
          response.upvote_from create(:user)
        end
        evaluator.downvotes.times do
          response.downvote_from create(:user)
        end
      end
    end
  end
end
