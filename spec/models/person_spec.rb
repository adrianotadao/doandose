require 'spec_helper'

describe 'Person' do
  it 'Should make a valid person' do
    FactoryGirl.build(:person).should be_valid
  end

  it 'Should have a name' do
    FactoryGirl.build(:person, name: nil).should_not be_valid
  end

  it 'Should have a surname' do
    FactoryGirl.build(:person, surname: nil).should_not be_valid
  end

  it 'Should have a sex' do
    FactoryGirl.build(:person, sex: '').should_not be_valid
  end

  it 'Should have a blood' do
    FactoryGirl.build(:person, blood: nil).should_not be_valid
  end

  it 'Should have a birthday' do
    FactoryGirl.build(:person, birthday: nil).should_not be_valid
  end

  it 'Should have a contact' do
    FactoryGirl.build(:person, contact: nil).should_not be_valid
  end

  it 'Should have a address' do
    FactoryGirl.build(:person, address: nil).should_not be_valid
  end

  it 'Should have a weight' do
    FactoryGirl.build(:person, weight: nil).should_not be_valid
  end

  it 'Should have a height' do
    FactoryGirl.build(:person, height: nil).should_not be_valid
  end

  it 'Should have a user' do
    FactoryGirl.build(:person, user: nil).should_not be_valid
  end

  it 'Observations is not required' do
    FactoryGirl.build(:person, observations: nil).should be_valid
  end
end