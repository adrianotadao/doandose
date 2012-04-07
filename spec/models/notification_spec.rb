require 'spec_helper'

describe 'Notification' do
  it 'Should have a valid notification' do
    Fabricate(:notification).should be_valid
  end
  
  it 'Should have a quantity' do
    Fabricate.build(:notification, :quantity => nil).should_not be_valid
  end
  
  it 'Should have a situation' do
    Fabricate.build(:notification, :situation => nil).should_not be_valid
  end
  
  it 'Should have a company' do
    Fabricate.build(:notification, :company => nil).should_not be_valid
  end
  
  it 'Should have a blood' do
    Fabricate.build(:notification, :blood => nil).should_not be_valid
  end
  
  it 'Should have a alert date' do
    Fabricate.build(:notification, :alerted_at => nil).should_not be_valid
  end
end