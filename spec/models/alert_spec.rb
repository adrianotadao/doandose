require 'spec_helper'

describe 'Alert' do
  it 'Should have a person' do
    FactoryGirl.build(:alert, person: nil).should_not be_valid
  end

  context 'Should have this methods' do
    it 'can_send_sms' do
      FactoryGirl.build(:alert).should respond_to :can_send_sms
    end

    it 'can_send_email' do
      FactoryGirl.build(:alert).should respond_to :can_send_email
    end

    it 'sms_list' do
      FactoryGirl.build(:alert).should respond_to :sms_list
    end

    it 'last_sms' do
      FactoryGirl.build(:alert).should respond_to :last_sms
    end

    it 'sms_counter' do
      FactoryGirl.build(:alert).should respond_to :sms_counter
    end

    it 'email_counter' do
      FactoryGirl.build(:alert).should respond_to :email_counter
    end

    it 'email_list' do
      FactoryGirl.build(:alert).should respond_to :email_list
    end

    it 'last_email' do
      FactoryGirl.build(:alert).should respond_to :last_email
    end

    it 'source_counter' do
      FactoryGirl.build(:alert).should respond_to :source_counter
    end

    it 'last_source' do
      FactoryGirl.build(:alert).should respond_to :last_source
    end

    it 'source_list' do
      FactoryGirl.build(:alert).should respond_to :source_list
    end
  end
end