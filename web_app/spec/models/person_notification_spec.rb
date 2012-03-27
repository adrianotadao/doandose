require 'spec_helper'

describe 'Address' do
  it 'Should have a valid person notifiation' do
    Fabricate(:person_notification).should be_valid
  end
  
  it 'Should have a notification' do
    Fabricate.build(:person_notification, :notification => nil).should_not be_valid
  end
  
  it 'Should have a person' do
    Fabricate.build(:person_notification, :person => nil).should_not be_valid
  end

  it 'Confirmed at is not required' do
    Fabricate.build(:person_notification, :confirmed_at => nil).should be_valid
  end

end