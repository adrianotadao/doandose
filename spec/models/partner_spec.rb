require 'spec_helper'

describe 'Partner' do
  it 'Should have a valid partner' do
    Fabricate(:partner).should be_valid
  end
  
  it 'Should have a name' do
    Fabricate.build(:partner, :name => nil).should_not be_valid
  end

  it 'Should have a logo' do
    Fabricate.build(:partner, :logo => nil).should_not be_valid
  end
  
  it 'Site is not required' do
    Fabricate.build(:partner, :site => nil).should be_valid
  end
end