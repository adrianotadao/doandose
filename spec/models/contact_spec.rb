require 'spec_helper'

describe 'Contact' do
  it 'Should have a valid contact' do
    FactoryGirl.build(:contact).should be_valid
  end

  context 'Phone and Cellphone' do
    it 'Number and ddd should not be null if cellphone is null' do
      FactoryGirl.build(:contact, ddd_phone: nil, phone: nil, cellphone: nil).should_not be_valid
    end

    it 'Phone number should be a string' do
      FactoryGirl.build(:contact).phone.is_a?(String).should be_true
    end

    it 'Cellphone Number should be a string' do
      FactoryGirl.build(:contact).cellphone.is_a?(String).should be_true
    end

    it 'Cellphone ddd should be a integer' do
      FactoryGirl.build(:contact).ddd_cellphone.is_a?(Integer).should be_true
    end

    it 'Phone ddd should be a integer' do
      FactoryGirl.build(:contact).ddd_phone.is_a?(Integer).should be_true
    end

    it 'Ddd cellphone should be included in valida ddds' do
      FactoryGirl.build(:contact, ddd_phone: 200).should_not be_valid
    end

    it 'Ddd phone should be included in valida ddds' do
      FactoryGirl.build(:contact, ddd_cellphone: 200).should_not be_valid
    end
  end

  context 'Should have this methods' do
    it 'Parse number to twilio plugin' do
      FactoryGirl.build(:contact).should respond_to :parse_to_twilio
    end
  end

  context 'Relationships' do
    it 'should relate to contactable' do
      FactoryGirl.build(:contact).should respond_to(:contactable)
    end
  end

  context 'Actions of methods' do
    it 'Should have to format number to twilio' do
      contact = FactoryGirl.build(:contact)
      contact.parse_to_twilio.should == "+55#{contact.ddd_cellphone}#{contact.cellphone}"
    end
  end
end