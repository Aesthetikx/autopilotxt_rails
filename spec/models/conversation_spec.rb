require 'spec_helper'

describe Conversation do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:conversation)).to be_valid
  end

  it 'belongs to a user' do
    expect(FactoryGirl.create(:conversation).user).to be_a(User)
  end

  it 'has many messages' do
    expect(FactoryGirl.create(:conversation)).to respond_to(:messages)
  end

  it 'has an expiration datetime' do
    expect(FactoryGirl.build(:conversation, expires_at: nil)).not_to be_valid
  end

  it 'is live if expiration date is in the future' do
    conversation = FactoryGirl.create(:conversation, expires_at: Time.now + 5.minutes)
    expect(conversation.live?).to be_true
    expect(conversation.expired?).to be_false
  end

  it 'is expired if expiration date is in the past' do
    conversation = FactoryGirl.create(:conversation, expires_at: Time.now - 5.minutes)
    expect(conversation.expired?).to be_true
    expect(conversation.live?).to be_false
  end

  it 'is respondable if expiration date is more than 30 seconds in the future' do
    expect(FactoryGirl.create(:conversation,
                              expires_at: Time.now + 35.seconds
                             ).respondable?).to be_true
    expect(FactoryGirl.create(:conversation,
                              expires_at: Time.now + 25.seconds
                             ).respondable?).to be_false
  end

  context 'scopes' do

    let(:expired_conv) { FactoryGirl.create(:conversation, expires_at: Time.now - 5.minutes) }
    let(:unexpired_conv) { FactoryGirl.create(:conversation, expires_at: Time.now + 5.minutes) }
    let(:thirty_five) { FactoryGirl.create(:conversation, expires_at: Time.now + 35.seconds) }
    let(:twenty_five) { FactoryGirl.create(:conversation, expires_at: Time.now + 25.seconds) }

    it 'has and expired scope' do
      expect(Conversation.expired).to include(expired_conv)
      expect(Conversation.expired).not_to include(unexpired_conv)
    end

    it 'has a live scope' do
      expect(Conversation.live).to include(unexpired_conv)
      expect(Conversation.live).not_to include(expired_conv)
    end

    it 'has a respondable scope' do
      expect(Conversation.respondable).to match_array([unexpired_conv, thirty_five])
    end

  end

end
