require 'spec_helper'

describe PersonCampaign do
  it 'Should have a valid person campaign' do
    FactoryGirl.build(:person_campaign).should be_valid
  end

  it 'Should have a notification' do
    FactoryGirl.build(:person_campaign, campaign: nil).should_not be_valid
  end

  it 'Should have a person' do
    FactoryGirl.build(:person_campaign, person: nil).should_not be_valid
  end

  it 'Confirmed at is not required' do
    FactoryGirl.build(:person_campaign, confirmed_at: nil).should be_valid
  end

  it 'Canceled at is not required' do
    FactoryGirl.build(:person_campaign, canceled_at: nil).should be_valid
  end

  it 'Alerted with is required' do
    FactoryGirl.build(:person_campaign, alerted_with: nil).should be_valid
  end

  context 'Should have this methods' do
    it 'send_email' do
      FactoryGirl.build(:person_campaign).should respond_to :send_email
    end
    it 'send_email_undo_confirm' do
      FactoryGirl.build(:person_campaign).should respond_to :send_email_undo_confirm
    end
    it 'non_canceled?' do
      FactoryGirl.build(:person_campaign).should respond_to :non_canceled?
    end
    it 'canceled?' do
      FactoryGirl.build(:person_campaign).should respond_to :canceled?
    end
  end
end