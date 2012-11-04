require 'spec_helper'

describe 'Authentication' do
  it 'Should make a valid authentication' do
    FactoryGirl.build(:authentication).should be_valid
  end

  it 'Should have a uid' do
    FactoryGirl.build(:authentication, uid_count: 0).should_not be_valid
  end

  it 'Should have a provider' do
    FactoryGirl.build(:authentication, provider: nil).should_not be_valid
  end

  it 'Should have a user' do
    FactoryGirl.build(:authentication, users_count: 0).should_not be_valid
  end

  it 'should have a unique provider per user' do
    authentication = FactoryGirl.create(:authentication)
    FactoryGirl.build(:authentication, provider: authentication.provider,
      user: authentication.user, users_count: 0).should_not be_valid
  end

  it 'should have a unique uid per provider' do
    authentication = FactoryGirl.create(:authentication)
    FactoryGirl.build(:authentication, provider: authentication.provider,
      uid: authentication.uid, uid_count: 0).should_not be_valid
  end
end