FactoryGirl.define do
  factory :conversation do
    user
    expires_at { Time.now + 3.minutes }

    factory :conversation_with_votes do
      ignore do
        upvotes 0
        downvotes 0
      end

      after(:create) do |conversation, evaluator|
        evaluator.upvotes.times do
          user = create(:user)
          conversation.upvote_from user
        end
        evaluator.downvotes.times do
          user = create(:user)
          conversation.downvote_from user
        end
      end
    end
  end
end
