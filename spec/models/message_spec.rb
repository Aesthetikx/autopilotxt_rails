require 'spec_helper'

describe Message do

  it 'has a valid factory' do
    message = FactoryGirl.create(:message)
    expect(message).to be_valid
  end

  it 'has requires a body' do
    message = FactoryGirl.create(:message, body: nil)
    expect(message).not_to be_valid
  end

  it 'has a non empty body' do
    message = FactoryGirl.create(:message, body: "")
    expect(message).not_to be_valid
  end

  it 'has a datestamp' do
    message = FactoryGirl.create(:message)
    expect(message.time).to be_a(DateTime)
  end

  it 'belongs to a conversation' do
    message = FactoryGirl.create(:message)
    expect(message.conversation).to be_a(Conversation)
  end

  it 'has valid sources uploader, recipient, autopilot' do
    message = FactoryGirl.create(:message)
    expect([0, 1, 2]).to include(message.source)

    message = FactoryGirl.create(:message, source: 3)
    expect(message).not_to be_valid

    message = FactoryGirl.create(:message, source: -1)
    expect(message).not_to be_valid
  end

end
