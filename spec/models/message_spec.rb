require 'spec_helper'

describe Message do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:message)).to be_valid
  end

  it 'has requires a body' do
    expect(FactoryGirl.build(:message, body: nil)).not_to be_valid
  end

  it 'has a non empty body' do
    expect(FactoryGirl.build(:message, body: "")).not_to be_valid
  end

  it 'has a datestamp' do
    expect(FactoryGirl.build(:message, time: nil)).not_to be_valid
  end

  it 'belongs to a conversation' do
    expect(FactoryGirl.build(:message).conversation).to be_a(Conversation)
  end

  it 'has valid sources uploader, recipient, autopilot' do
    message = FactoryGirl.build(:message)
    expect(message).to respond_to(:uploader?)
    expect(message).to respond_to(:recipient?)
    expect(message).to respond_to(:autopilot?)
    expect(message).to respond_to(:uploader!)
    expect(message).to respond_to(:recipient!)
    expect(message).to respond_to(:autopilot!)

    message.uploader!
    expect(message.uploader?).to be_true

    message.recipient!
    expect(message.recipient?).to be_true

    message.autopilot!
    expect(message.autopilot?).to be_true
  end

end
