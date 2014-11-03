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
      a = FactoryGirl.create(:response)
      b = FactoryGirl.create(:response)

      a.stub(:score).and_return(3)
      b.stub(:score).and_return(2)

      user.responses << a
      user.responses << b

      expect(user.response_score).to eq(5)
    end

    it 'has a score for conversations' do
      a = FactoryGirl.create(:conversation_with_votes, user: user, upvotes: 5, downvotes: 2, sent: true)  # 4 (1 + 5 - 2)
      b = FactoryGirl.create(:conversation_with_votes, user: user, upvotes: 3, downvotes: 5, sent: true)  # -1 (1 + 3 - 5)
      c = FactoryGirl.create(:conversation_with_votes, user: user, upvotes: 7, downvotes: 1, sent: false) # 1 (unsent)

      # +3 for conversation a
      3.times do
        FactoryGirl.create(:response, conversation: a)
      end

      expect(user.submission_score).to eq(7)
    end

  end

end
