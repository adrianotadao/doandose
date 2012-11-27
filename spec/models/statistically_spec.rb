require 'spec_helper'

describe Statistically do
  it 'Should respond to total_person method' do
    Statistically.should respond_to :total_person
  end

  it 'Should respond to amount_of_blood_type method' do
    Statistically.should respond_to :amount_of_blood_type
  end

  it 'Should respond to percentage_blood_type method' do
    Statistically.should respond_to :percentage_blood_type
  end

  it 'Should respond to percentage_gender method' do
    Statistically.should respond_to :percentage_gender
  end

  it 'Should respond to indexed_ages_more method' do
    Statistically.should respond_to :indexed_ages_more
  end

  it 'Should respond to joined_by_blood_type method' do
    Statistically.should respond_to :joined_by_blood_type
  end
end