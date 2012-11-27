require 'spec_helper'

describe Campaign do
  it 'Should have a valid address' do
    FactoryGirl.build(:campaign).should be_valid
  end

  it 'Active must be true or false' do
    FactoryGirl.build(:campaign, active: 'foo').should_not be_valid
  end

  it 'Should have a company' do
    FactoryGirl.build(:campaign, company: nil).should_not be_valid
  end

  it 'Should have a blood' do
    FactoryGirl.build(:campaign, blood: nil).should_not be_valid
  end

  it 'Should have a title' do
    FactoryGirl.build(:campaign, title: nil).should_not be_valid
  end

  it 'Should have a content' do
    FactoryGirl.build(:campaign, content: nil).should_not be_valid
  end

  it 'Should have a quantity' do
    FactoryGirl.build(:campaign, quantity: nil).should_not be_valid
  end

  it 'Should have a expired_at' do
    FactoryGirl.build(:campaign, expired_at: nil).should_not be_valid
  end

  it 'Quantity must be a number' do
    FactoryGirl.build(:campaign, quantity: 'foo').should_not be_valid
  end

  context 'Relationships' do
    it 'should relate to person_campaigns' do
      FactoryGirl.build(:campaign).should respond_to(:person_campaigns)
    end
  end

  context 'Should have this methods' do
    it 'campaign_confirmed' do
      FactoryGirl.build(:campaign).should respond_to(:campaign_confirmed)
    end

    it 'will_participate' do
      FactoryGirl.build(:campaign).should respond_to(:will_participate)
    end
  end
end