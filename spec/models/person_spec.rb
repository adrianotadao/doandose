require 'spec_helper'

describe 'Person' do
  it 'Should make a valid person' do
    Fabricate(:person).should be_valid
  end
  
  context 'Current step is information' do
    it 'Should have a name' do
      Fabricate.build(:person, :name => nil, :current_step => 'information').should_not be_valid
    end    

    it 'Should have a surname' do
      Fabricate.build(:person, :surname => nil, :current_step => 'information').should_not be_valid
    end

    it 'Should have a sex' do    
      Fabricate.build(:person, :sex => nil, :current_step => 'information').should_not be_valid
    end

    it 'Should have a blood' do
      Fabricate.build(:person, :blood => nil, :current_step => 'information').should_not be_valid
    end  

    it 'Should have a birthday' do
      Fabricate.build(:person, :birthday => nil, :current_step => 'information').should_not be_valid
    end 
    
    it 'Should have a contact' do
      Fabricate.build(:person, :contact => nil, :current_step => 'information').should_not be_valid
    end

    it 'Should have a address' do
      Fabricate.build(:person, :address => nil, :current_step => 'information').should_not be_valid
    end

    it 'Should have a weight' do
      Fabricate.build(:person, :weight => nil, :current_step => 'information').should_not be_valid
    end

    it 'Should have a height' do
      Fabricate.build(:person, :height => nil, :current_step => 'information').should_not be_valid
    end


  end
  
  context 'Current step is confirmation' do  
    it 'Should have a lat' do
      Fabricate.build(:person, :lat => nil, :current_step => 'confirmation').should_not be_valid
    end
  
    it 'Should have a lng' do
      Fabricate.build(:person, :lng => nil, :current_step => 'confirmation').should_not be_valid
    end
  end

  context 'Current step is user' do  
    it 'Should have a user' do
      Fabricate.build(:person, :user => nil, :current_step => 'user').should_not be_valid
    end
  end

  
  it 'Observations is not required' do
    Fabricate.build(:person, :observations => nil).should be_valid
  end
end