require 'spec_helper'

describe 'User' do
  it 'Should make a valid user' do
    Fabricate(:user).should be_valid
  end
  
  it 'Name should be null' do
    Fabricate.build(:user, :name => nil).should be_valid
  end
  
end