require 'spec_helper'

describe 'Notification' do
  it 'Should have a valid notification' do
    pending
    FactoryGirl.build(:notification).should be_valid
  end

  it 'Should have a quantity' do
    pending
    FactoryGirl.build(:notification, quantity: nil).should_not be_valid
  end

  it 'Should have a situation' do
    pending
    FactoryGirl.build(:notification, situation: nil).should_not be_valid
  end

  it 'Should have a company' do
    pending
    FactoryGirl.build(:notification, company: nil).should_not be_valid
  end

  it 'Should have a blood' do
    pending
    FactoryGirl.build(:notification, blood: nil).should_not be_valid
  end

end