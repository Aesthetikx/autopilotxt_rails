require 'spec_helper'

describe Response do

  context 'validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.build(:response)).to be_valid
    end

    it 'requires a body' do
      expect(FactoryGirl.build(:response, body: nil)).not_to be_valid
    end

    it 'requires a user' do
      expect(FactoryGirl.build(:response, user: nil)).not_to be_valid
    end

    it 'requires a conversation' do
      expect(FactoryGirl.build(:response, conversation: nil)).not_to be_valid
    end
  end

  it 'belongs to a user' do
    expect(FactoryGirl.build(:response).user).to be_a(User)
  end

  it 'belongs to a conversation' do
    expect(FactoryGirl.build(:response).conversation).to be_a(Conversation)
  end

end
