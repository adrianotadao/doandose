require 'spec_helper'

describe 'Gmap' do
  it 'Should respond to elements_by_distance method' do
    GMap.should respond_to :elements_by_distance
  end

  it 'Should respond to distance method' do
    GMap.should respond_to :distance
  end

  it 'Should respond to parse_distance method' do
    GMap.should respond_to :parse_distance
  end
end