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
      a = FactoryGirl.create(:conversation)
      b = FactoryGirl.create(:conversation)

      a.stub(:score).and_return(4)
      b.stub(:score).and_return(5)

      user.conversations << a
      user.conversations << b

      expect(user.submission_score).to eq(4 + 5 + 2)
    end

  end

end
