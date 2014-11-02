require 'spec_helper'

describe ConversationsController do

  describe "GET /conversations/top" do

    it 'sorts by votes'

  end

  describe "GET /conversations/new" do

    it 'returns live conversations' do
      conversations = [
        FactoryGirl.create(:conversation, expires_at: Time.now - 3.minutes),
        FactoryGirl.create(:conversation, expires_at: Time.now + 3.minutes)
      ]
      get '/conversations/new'
      expect(assigns(:conversations)).to match_array(conversations.select(&:live?))
    end

    it 'returns conversations with at least 30 seconds remaining' do
      conversations = [
        FactoryGirl.create(:conversation, expires_at: Time.now + 3.minutes),
        FactoryGirl.create(:conversation, expires_at: Time.now + 5.seconds)
      ]
      get '/conversations/new'
      expect(assigns(:conversations).sort).to match_array(conversations.select { |c| c.expires_at > Time.now + 30.seconds })
    end

    it 'sorts by expired_at, newest first' do
      conversations = [
        FactoryGirl.create(:conversation, expires_at: Time.now + 3.minutes),
        FactoryGirl.create(:conversation, expires_at: Time.now + 4.minutes),
        FactoryGirl.create(:conversation, expires_at: Time.now + 1.minutes)
      ]
      get '/conversations/new'
      expect(assigns(:conversations)).to eq(conversations.sort_by { |c| c.expires_at })
    end

  end

  describe "GET /conversations/old" do

    it 'returns live conversations'

    it 'returns conversations with at least 30 seconds remaining'

    it 'sorts by expired_at, closest first'

  end

  describe "GET /conversations/hot" do

    it 'returns live conversations'

    it 'returns conversations with at least 30 seconds remaining'

    it 'sorts by votes, highest first'

  end

end
