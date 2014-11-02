require 'spec_helper'

describe Message do

  it 'has a valid factory' do
    message = FactoryGirl.create(:message)
    expect(message).to be_valid
  end

  it 'has a non empty body' do
    message = FactoryGirl.create(:message, body: "")
    expect(message).not_to be_valid
  end

  it 'has a datestamp' do
    message = FactoryGirl.create(:message)
    expect(message.time).to be_a(Datetime)
  end

  it 'belongs to a conversation' do
    message = FactoryGirl.create(:message)
    expect(message.conversation).to be_a(Conversation)
  end

  it 'has a source'

  it 'has valid sources uploader, recipient, autopilot'

end
