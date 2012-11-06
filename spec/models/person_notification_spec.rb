require 'spec_helper'

describe 'PersonNotification' do
  it 'Should have a valid person notifiation' do
    FactoryGirl.build(:person_notification).should be_valid
  end

  it 'Should have a notification' do
    FactoryGirl.build(:person_notification, notification: nil).should_not be_valid
  end

  it 'Should have a person' do
    FactoryGirl.build(:person_notification, person: nil).should_not be_valid
  end

  it 'Confirmed at is not required' do
    FactoryGirl.build(:person_notification, confirmed_at: nil).should be_valid
  end

  it 'Canceled at is not required' do
    FactoryGirl.build(:person_notification, canceled_at: nil).should be_valid
  end

  it 'Alerted with is required' do
    FactoryGirl.build(:person_notification, alerted_with: nil).should_not be_valid
  end

  context 'Should have this methods' do
    it 'send_email_undo_confirm' do
      FactoryGirl.build(:person_notification).should respond_to :send_email_undo_confirm
    end
    it 'send_email_confirmation' do
      FactoryGirl.build(:person_notification).should respond_to :send_email_confirmation
    end
  end
end