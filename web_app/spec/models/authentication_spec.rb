require 'spec_helper'

describe 'Authentication' do
  it 'Should make a valid authentication' do
    Fabricate(:authentication).should be_valid
  end
  
  it 'Should have a uid' do
    Fabricate.build(:authentication, :uid => nil).should_not be_valid
  end
  
  it 'Should have a provider' do
    Fabricate.build(:authentication, :provider => nil).should_not be_valid
  end
  
  it 'Should have a user' do
    Fabricate.build(:authentication, :user => nil).should_not be_valid
  end
  
  it 'should have a unique provider per user' do
    authentication = Fabricate(:authentication)
    Fabricate.build(:authentication, :provider => authentication.provider, :user => authentication.user).should_not be_valid
  end
  
  it 'should have a unique uid per provider' do
    authentication = Fabricate(:authentication)
    Fabricate.build(:authentication, :provider => authentication.provider, :uid => authentication.uid).should_not be_valid
  end
  
end