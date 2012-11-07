require 'spec_helper'

describe Ddd do
  it 'Should respond to possibles method' do
    Ddd.should respond_to :possibles
  end
end