require 'spec_helper'

describe 'Testimonial' do
  it 'Should make a valid testimonial' do
    Fabricate(:testimonial).should be_valid
  end
end