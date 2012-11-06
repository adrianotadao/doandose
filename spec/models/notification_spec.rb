require 'spec_helper'

describe 'Notification' do
  it 'Should have a valid notification' do
    FactoryGirl.build(:notification).should be_valid
  end

  it 'Should have a blood type if new record' do
    FactoryGirl.build(:notification, blood_type: nil).should_not be_valid
    notification = FactoryGirl.create(:notification)
    notification.blood_type = nil
    notification.should be_valid
  end

  it 'Should have a quantity' do
    FactoryGirl.build(:notification, quantity: nil).should_not be_valid
  end

  it 'Situation must be included in urgent or moderate' do
    FactoryGirl.build(:notification, situation: 'foo').should_not be_valid
  end

  it 'Should have a situation' do
    FactoryGirl.build(:notification, situation: nil).should_not be_valid
  end

  it 'Should have a company' do
    FactoryGirl.build(:notification, company: nil).should_not be_valid
  end

  it 'Should have a blood' do
    FactoryGirl.build(:notification, blood: nil).should_not be_valid
  end

  context 'Relationships' do
    it 'should relate to person_notifications' do
      FactoryGirl.build(:notification).should respond_to(:person_notifications)
    end
  end

  context 'Should have this methods' do
    it 'Should be have send_sms' do
      FactoryGirl.build(:notification).should respond_to :send_sms
    end

    it 'Should be have send_email' do
      FactoryGirl.build(:notification).should respond_to :send_email
    end

    it 'Should be have will_participate?' do
      FactoryGirl.build(:notification).should respond_to :will_participate?
    end

    it 'Should be have remaining?' do
      FactoryGirl.build(:notification).should respond_to :remaining
    end

    it 'Should be have notification_confirmed?' do
      FactoryGirl.build(:notification).should respond_to :notification_confirmed
    end
  end
end