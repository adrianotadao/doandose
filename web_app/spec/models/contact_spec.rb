require 'spec_helper'

describe 'Contact' do
  it 'Should make a valid contact' do
    Fabricate(:contact).should be_valid
  end
  
  it 'Should have a email' do
    Fabricate.build(:contact, :email => nil).should_not be_valid
  end
  
  it 'Should have phone or cellphone' do
    Fabricate.build(:contact, :phone => nil, :cellphone => nil).should_not be_valid
  end
end