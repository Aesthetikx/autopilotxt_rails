require 'spec_helper'

describe Conversation do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:conversation)).to be_valid
  end

  it 'belongs to a user' do
    conversation = FactoryGirl.create(:conversation)
    expect(conversation.user).to be_a(User)
  end

  it 'has many messages' do
    conversation = FactoryGirl.create(:conversation)
    expect(conversation.messages).to be_a(Array)
  end

  it 'has an expiration datetime' do
    conversation = FactoryGirl.create(:conversation)
    expect(conversation.expires_at).to be_a(DateTime)
  end

end
