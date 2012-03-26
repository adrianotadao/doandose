require 'spec_helper'

describe 'User' do
  it 'Should make a valid user' do
    Fabricate(:user).should be_valid
  end
  
  it 'Name should be null' do
    Fabricate.build(:user, :name => nil).should be_valid
  end
  
  context 'Password' do
    it 'should have a password if provider is autentity' do
      pending
    end
    
    it 'should confirm password' do
      pending
      Fabricate.build(:user, :password => '123', :password_confirmation => '123').should be_valid
      Fabricate.build(:user, :password => '123', :password_confirmation => '123456').should_not be_valid
    end
    
  end
  
end