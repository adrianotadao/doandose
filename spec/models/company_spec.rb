require 'spec_helper'

describe 'Company' do
  it 'should make a valid company' do
    FactoryGirl.build(:company).should be_valid
  end

  context 'Name' do
    it 'should not be null' do
      FactoryGirl.build(:company, name: nil).should_not be_valid
    end

    it 'should be unique' do
      company = FactoryGirl.create(:company)
      FactoryGirl.build(:company, name: company.name).should_not be_valid
    end
  end

  context 'Fancy name' do
    it 'should not be null' do
      FactoryGirl.build(:company, fancy_name: nil).should_not be_valid
    end

    it 'should be unique' do
      company = FactoryGirl.create(:company)
      FactoryGirl.build(:company, fancy_name: company.fancy_name).should_not be_valid
    end
  end

  context 'cnpj' do
    it 'should not be null' do
      FactoryGirl.build(:company, cnpj: nil).should_not be_valid
    end
    it 'should be unique' do
      company = FactoryGirl.create(:company)
      FactoryGirl.build(:company, cnpj: company.cnpj).should_not be_valid
    end
  end

  context 'Relationships' do
    it 'should relate to notifications' do
      FactoryGirl.build(:company).should respond_to(:notifications)
    end
  end

  it 'Should have a address' do
    FactoryGirl.build(:company, address: nil).should_not be_valid
  end

  it 'Should have a contact' do
    FactoryGirl.build(:company, contact: nil).should_not be_valid
  end

  it 'Should have a responsible' do
    FactoryGirl.build(:company, responsible: nil).should_not be_valid
  end
end