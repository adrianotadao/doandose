require 'spec_helper'

describe 'Authentication' do
  it 'Should make a valid authentication' do
    FactoryGirl.build(:authentication).should be_valid
  end

  it 'Should have a user' do
    FactoryGirl.build(:authentication, users_count: 0).should_not be_valid
  end

  describe 'provider' do
    it 'valid provider list' do
      FactoryGirl.build(:authentication, provider: 'facebook').should be_valid
      FactoryGirl.build(:authentication, provider: 'twitter').should be_valid
      FactoryGirl.build(:authentication, provider: 'google_oauth2').should be_valid
      FactoryGirl.build(:authentication, provider: 'identity').should be_valid
    end
    it 'should have a unique uid per provider' do
      authentication = FactoryGirl.create(:authentication)
      FactoryGirl.build(:authentication, provider: authentication.provider,
        uid: authentication.uid, uid_count: 0).should_not be_valid
    end
    it 'Should have a provider' do
      FactoryGirl.build(:authentication, provider: nil).should_not be_valid
    end
    it 'should have a valid provider' do
      FactoryGirl.build(:authentication, provider: 'linkedin').should_not be_valid
    end
    it 'should be a string' do
      FactoryGirl.build(:authentication).provider.is_a?(String).should be_true
    end
    it 'should have a unique provider per user' do
      authentication = FactoryGirl.create(:authentication)
      FactoryGirl.build(:authentication, provider: authentication.provider,
        user: authentication.user, users_count: 0).should_not be_valid
    end
  end

  describe 'uid' do
    it 'should be a string' do
      FactoryGirl.build(:authentication).uid.is_a?(String).should be_true
    end
    it 'Should have a uid' do
      FactoryGirl.build(:authentication, uid_count: 0).should_not be_valid
    end
  end
end