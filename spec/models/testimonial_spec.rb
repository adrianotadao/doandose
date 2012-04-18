require 'spec_helper'

describe 'Testimonial' do
  it 'Should make a valid testimonial' do
    Fabricate(:testimonial).should be_valid
  end
  
  it 'Person is not required' do
    Fabricate.build(:testimonial, :person => nil).should be_valid
  end
  
  it 'Company is not required' do
    Fabricate.build(:testimonial, :company => nil).should be_valid
  end
end