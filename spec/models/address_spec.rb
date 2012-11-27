require 'spec_helper'

describe Address do
  it 'Should have a valid address' do
    FactoryGirl.build(:address).should be_valid
  end

  it 'Lat should not be required' do
    FactoryGirl.build(:address, lat: nil).should be_valid
  end

  it 'Lng should not be required' do
    FactoryGirl.build(:address, lng: nil).should be_valid
  end

  context 'Zip code' do
    it 'Should not be null' do
      FactoryGirl.build(:address, zip_code: nil).should_not be_valid
    end
    it 'Should be a string' do
      FactoryGirl.build(:address).zip_code.is_a?(String).should be_true
    end
  end

  context 'Number' do
    it 'Should not be null' do
      FactoryGirl.build(:address, number: nil).should_not be_valid
    end
    it 'Should be a String' do
      FactoryGirl.build(:address).number.is_a?(String).should be_true
    end
  end

  context 'Street' do
    it 'Should have a street' do
      FactoryGirl.build(:address, street: nil).should_not be_valid
    end
    it 'Should be a String' do
      FactoryGirl.build(:address).street.is_a?(String).should be_true
    end
  end

  context 'Neighborhood' do
    it 'Should have a neighborhood' do
      FactoryGirl.build(:address, neighborhood: nil).should_not be_valid
    end
    it 'Should be a String' do
      FactoryGirl.build(:address).neighborhood.is_a?(String).should be_true
    end
  end

  context 'Complement' do
    it 'Complement should not be required' do
      FactoryGirl.build(:address, complement: nil).should be_valid
    end
    it 'Should be a String' do
      FactoryGirl.build(:address).complement.is_a?(String).should be_true
    end
  end

  context 'City' do
    it 'Should have a city' do
      FactoryGirl.build(:address, city: nil).should_not be_valid
    end
    it 'Should be a String' do
      FactoryGirl.build(:address).city.is_a?(String).should be_true
    end
  end

  context 'State' do
    it 'Should have a state' do
      FactoryGirl.build(:address, state: nil).should_not be_valid
    end
    it 'Should be a String' do
      FactoryGirl.build(:address).state.is_a?(String).should be_true
    end
  end

  context 'Loc' do
    it 'Loc should not be required' do
      FactoryGirl.build(:address, loc: nil).should be_valid
    end
    it 'Loc should be a array' do
      FactoryGirl.build(:address).loc.is_a?(Array).should be_true
    end
  end

  context 'Should have this methods' do
    it 'Formated address' do
      FactoryGirl.build(:address).should respond_to :formated_address
    end
    it 'Parse location' do
      FactoryGirl.build(:address).should respond_to :parse_location
    end
    it 'full_coordinate' do
      FactoryGirl.build(:address).should respond_to :full_coordinate
    end
  end

  context 'Relationships' do
    it 'should relate to addressable' do
      FactoryGirl.build(:address).should respond_to(:addressable)
    end
  end

  context 'Actions of methods' do
    it 'Should have to format the address' do
      address = FactoryGirl.build(:address)
      address.formated_address.should == "#{address.street}, #{address.neighborhood} - #{address.number}, #{address.city} - #{address.state}"
    end

    it 'Should have to return full coordinates' do
      address = FactoryGirl.build(:address)
      address.full_coordinate.should == "#{address.loc[0]}, #{address.loc[1]}"
    end

    it 'Should parse the location' do
      address = FactoryGirl.build(:address, loc: [])
      address.loc.should == []
      address.valid?
      address.loc.should == [address.lat, address.lng]
    end
  end
end