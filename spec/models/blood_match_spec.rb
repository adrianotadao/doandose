require 'spec_helper'

describe BloodMatch do
  it 'Should respond to receives method' do
    BloodMatch.should respond_to :receives
  end

  it 'Should respond to donor method' do
    BloodMatch.should respond_to :donor
  end
end