require 'spec_helper'

describe 'Blood' do
  it 'Should have a valid blood' do
    FactoryGirl.build(:blood).should be_valid
  end

  describe 'Name' do
    it 'Should not be null' do
      FactoryGirl.build(:blood, name: nil).should_not be_valid
    end
    it 'Should be a string' do
      FactoryGirl.build(:blood).name.is_a?(String).should be_true
    end
  end
end