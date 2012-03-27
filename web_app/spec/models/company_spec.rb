require 'spec_helper'

describe 'Company' do
  it 'Should make a valid company' do
    Fabricate(:company).should be_valid
  end
  
  context 'Name' do  
    it 'should not be null' do
      Fabricate.build(:company, :name => nil).should_not be_valid
    end
    
    it 'should be unique' do
      company = Fabricate(:company)
      Fabricate.build(:company, :name => company.name).should_not be_valid
    end
  end
  
  context 'Fancy name' do  
    it 'should not be null' do
      Fabricate.build(:company, :fancy_name => nil).should_not be_valid
    end
    
    it 'should be unique' do
      company = Fabricate(:company)
      Fabricate.build(:company, :fancy_name => company.fancy_name).should_not be_valid
    end
  end
  
  it 'Cpnj is not required' do
    Fabricate.build(:company, :cnpj => nil).should be_valid
  end
  
  it 'Should have a address' do
    Fabricate.build(:company, :address => nil).should_not be_valid
  end
  
  it 'Should have a contact' do
    Fabricate.build(:company, :contact => nil).should_not be_valid
  end
  
  it 'Should have a responsible' do
    Fabricate.build(:company, :responsible => nil).should_not be_valid
  end
  
end