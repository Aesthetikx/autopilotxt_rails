require 'spec_helper'

describe ConversationsController do

  describe "GET /conversations/new" do
    it 'sorts by created_at, newest first' do
      conversations = [
        FactoryGirl.create(:conversation, created_at: Time.now + 3.minutes),
        FactoryGirl.create(:conversation, created_at: Time.now + 4.minutes),
        FactoryGirl.create(:conversation, created_at: Time.now + 1.minutes)
      ]
      get :new
      expect(assigns(:conversations).to_a).to eq(conversations.sort_by { |c| c.created_at }.reverse)
    end
  end

  describe "GET /conversations/old" do
    it 'sorts by expired_at, closest first' do
      conversations = [
        FactoryGirl.create(:conversation, expires_at: Time.now + 3.minutes),
        FactoryGirl.create(:conversation, expires_at: Time.now + 4.minutes),
        FactoryGirl.create(:conversation, expires_at: Time.now + 1.minutes)
      ]
      get :old
      expect(assigns(:conversations).to_a).to eq(conversations.sort_by { |c| c.expires_at })
    end
  end

  describe "sort by votes" do
    it 'sorts by votes for hot and top' do
      a = FactoryGirl.create(:conversation_with_votes, upvotes: 5, downvotes: 2) #3
      b = FactoryGirl.create(:conversation_with_votes, upvotes: 8, downvotes: 1) #7
      c = FactoryGirl.create(:conversation_with_votes, upvotes: 1, downvotes: 3) #-2
      [:top, :hot].each do |route|
        get route
        expect(assigns(:conversations).to_a).to eq([b, a, c])
      end
    end
  end

  describe "current" do
    it 'returns live conversations' do
      conversations = [
        FactoryGirl.create(:conversation, expires_at: Time.now - 3.minutes),
        FactoryGirl.create(:conversation, expires_at: Time.now + 3.minutes)
      ]

      [:new, :old, :hot].each do |route|
        get route
        expect(assigns(:conversations)).to match_array(conversations.select(&:live?))
      end
    end

    it 'returns conversations with at least 30 seconds remaining' do
      conversations = [
        FactoryGirl.create(:conversation, expires_at: Time.now + 3.minutes),
        FactoryGirl.create(:conversation, expires_at: Time.now + 5.seconds)
      ]

      [:new, :old, :hot].each do |route|
        get route
        expect(assigns(:conversations).sort).to match_array(conversations.select(&:respondable?))
      end
    end
  end

end
