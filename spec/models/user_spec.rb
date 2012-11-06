require 'spec_helper'

describe 'User' do
  it 'Should have a valid user' do
    FactoryGirl.build(:user).should be_valid
  end
end