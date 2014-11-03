require 'spec_helper'

describe User do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it 'requires a username' do
    expect(FactoryGirl.build(:user, username: nil)).not_to be_valid
  end

  it 'has a username' do
    expect(FactoryGirl.build(:user)).not_to be_blank
  end

  it 'has many conversations' do
    expect(FactoryGirl.build(:user)).to respond_to(:conversations)
  end

  context 'score' do

    let(:user) { FactoryGirl.create(:user) }

    it 'has a score for responses' do
      a = FactoryGirl.create(:response, user: user, upvotes: 4, downvotes: 2) # 2
      b = FactoryGirl.create(:response, user: user, upvotes: 6, downvotes: 2) # 4

      expect(user.response_score).to eq(6)
    end

    it 'has a score for conversations' do
      a = FactoryGirl.create(:conversation, user: user, upvotes: 5, downvotes: 2, response_count: 3, sent: true)  # 7 (1 + 5 - 2 + 3 responses)
      b = FactoryGirl.create(:conversation, user: user, upvotes: 3, downvotes: 5, sent: true)  # -1 (1 + 3 - 5)
      c = FactoryGirl.create(:conversation, user: user, upvotes: 7, downvotes: 1, sent: false) # 1 (unsent)

      expect(user.submission_score).to eq(7)
    end

  end

end
