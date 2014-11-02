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

end
