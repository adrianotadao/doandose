require 'spec_helper'

describe 'Blood' do
  it 'Should make a valid blood' do
    Fabricate(:blood).should be_valid
  end
  
  context 'Name' do
    it 'should not be null' do
      Fabricate.build(:blood, :name => nil).should_not be_valid
    end
  
    it 'should have a uniqueness' do
      blood = Fabricate(:blood)
      Fabricate.build(:blood, :name => blood.name).should_not be_valid
    end
  end
  
  it 'people is not required' do
    Fabricate.build(:blood, :peolpe => nil).should be_valid
  end
end