require 'spec_helper'

describe Person do
  it 'Should make a valid person' do
    FactoryGirl.build(:person).should be_valid
  end

  context 'name' do
    it 'should not be null' do
      FactoryGirl.build(:person, name: nil).should_not be_valid
    end

    it 'can not be larger then 30 characters' do
      FactoryGirl.build(:person, name: 'foo bar foo bar foo bar foo bar foo').should_not be_valid
    end

    it 'can not be less then 2 characters' do
      FactoryGirl.build(:person, name: 'f').should_not be_valid
    end
  end

  it 'Should have a surname' do
    FactoryGirl.build(:person, surname: nil).should_not be_valid
  end

  context 'Sex' do
    it 'Should not be null' do
      FactoryGirl.build(:person, sex: '').should_not be_valid
    end

    it 'Should have include in f or m' do
      FactoryGirl.build(:person, sex: 'foo').should_not be_valid
    end
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

  it 'Donor should be a boolean' do
    FactoryGirl.build(:person, donor: 'foo').should_not be_valid
  end

  context 'weight' do
    it 'Should not be null' do
      FactoryGirl.build(:person, weight: nil).should_not be_valid
    end

    it 'should be a number' do
      FactoryGirl.build(:person, weight: 'foo').should_not be_valid
    end
  end

  context 'height' do
    it 'should not be null' do
      FactoryGirl.build(:person, height: nil).should_not be_valid
    end

    it 'should be a number' do
      FactoryGirl.build(:person, height: 'foo').should_not be_valid
    end
  end

  it 'Should have a user' do
    FactoryGirl.build(:person, user: nil).should_not be_valid
  end

  it 'Observations is not required' do
    FactoryGirl.build(:person, observations: nil).should be_valid
  end

  context 'Should have this methods' do
    it 'blood donors' do
      FactoryGirl.build(:person).should respond_to :blood_donors
    end
  end

  context 'Relationships' do
    it 'should relate to blood' do
      FactoryGirl.build(:person).should respond_to(:blood)
    end

    it 'should relate to person_notifications' do
      FactoryGirl.build(:person).should respond_to(:person_notifications)
    end

    it 'should relate to person_campaigns' do
      FactoryGirl.build(:person).should respond_to(:person_campaigns)
    end

    it 'should relate to alerts' do
      FactoryGirl.build(:person).should respond_to(:alerts)
    end
  end
end