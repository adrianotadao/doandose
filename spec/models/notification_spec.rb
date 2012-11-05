require 'spec_helper'

describe 'Notification' do
  it 'Should have a valid notification' do
    FactoryGirl.build(:notification).should be_valid
  end

  it 'Should have a quantity' do
    FactoryGirl.build(:notification, :quantity => nil).should_not be_valid
  end

  it 'Should have a situation' do
    FactoryGirl.build(:notification, :situation => nil).should_not be_valid
  end

  it 'Should have a company' do
    FactoryGirl.build(:notification, :company => nil).should_not be_valid
  end

  it 'Should have a blood' do
    FactoryGirl.build(:notification, :blood => nil).should_not be_valid
  end

  it 'Should have a alert date' do
    FactoryGirl.build(:notification, :alerted_at => nil).should_not be_valid
  end
end