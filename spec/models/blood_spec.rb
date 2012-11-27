require 'spec_helper'

describe Blood do
  it 'Should have a valid blood' do
    FactoryGirl.build(:blood).should be_valid
  end

  context 'Name' do
    it 'Should not be null' do
      FactoryGirl.build(:blood, name: nil).should_not be_valid
    end
    it 'Should be unique' do
      blood = FactoryGirl.create(:blood)
      FactoryGirl.build(:blood, name: blood.name).should_not be_valid
    end
    it 'Should be a string' do
      FactoryGirl.build(:blood).name.is_a?(String).should be_true
    end
  end

  context 'Relationships' do
    it 'should relate to people' do
      FactoryGirl.build(:blood).should respond_to(:people)
    end

    it 'should relate to notifications' do
      FactoryGirl.build(:blood).should respond_to(:notifications)
    end
  end
end