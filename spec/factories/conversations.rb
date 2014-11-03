FactoryGirl.define do
  factory :conversation do
    user
    expires_at { Time.now + 3.minutes }

    ignore do
      upvotes 0
      downvotes 0
      response_count 0
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
      evaluator.response_count.times do
        conversation.responses << create(:response)
      end
    end

  end
end
