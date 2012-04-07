require 'spec_helper'

describe 'Address' do
  it 'Should have a valid address' do
    Fabricate(:address).should be_valid
  end
  
  it 'Should have a zip code' do
    Fabricate.build(:address, :zip_code => nil).should_not be_valid
  end
  
  it 'Should have a number' do
    Fabricate.build(:address, :number => nil).should_not be_valid
  end
  
  it 'Should have a street' do
    Fabricate.build(:address, :street => nil).should_not be_valid
  end
  
  it 'Should have a neightborhood' do
    Fabricate.build(:address, :neighborhood => nil).should_not be_valid
  end
  
  it 'Should have a city' do
    Fabricate.build(:address, :city => nil).should_not be_valid
  end
  
  it 'Should have a state' do
    Fabricate.build(:address, :state => nil).should_not be_valid
  end
  
end