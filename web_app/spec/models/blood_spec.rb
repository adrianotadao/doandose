require 'spec_helper'

describe 'Blood' do
  it 'Should make a valid blood' do
    #p Blood.new
    p Fabricate(:blood)
  end

  it 'Should have a name' do
    
  end
end