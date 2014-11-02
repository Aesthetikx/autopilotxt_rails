require 'spec_helper'

describe Conversation do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:conversation)).to be_valid
  end

  it 'belongs to a user' do
    expect(FactoryGirl.create(:conversation).user).to be_a(User)
  end

  it 'has many messages' do
    expect(FactoryGirl.create(:conversation)).to be_a(Array)
  end

  it 'has an expiration datetime' do
    expect(FactoryGirl.create(:conversation, expires_at: nil)).not_to be_valid
  end

end
