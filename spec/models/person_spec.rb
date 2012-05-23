require 'spec_helper'

describe 'Person' do
  
  it 'Verify current state that' do
    person = Fabricate.build(:person)

    if person.current_step == 'information'

      it 'Should make a valid person' do
        Fabricate(:person).should be_valid
      end
      
      it 'Should have a name' do
        Fabricate.build(:person, :name => nil).should_not be_valid
      end
      
      it 'Should have a surname' do
        Fabricate.build(:person, :surname => nil).should_not be_valid
      end
      
      it 'Should have a sex' do    
        Fabricate.build(:person, :sex => nil).should_not be_valid
      end
      
      it 'Should have a blood' do
        Fabricate.build(:person, :blood => nil).should_not be_valid
      end  
    
      it 'Should have a birthday' do
        Fabricate.build(:person, :birthday => nil).should_not be_valid
      end 
      
      it 'Should have a contact' do
        Fabricate.build(:person, :contact => nil).should_not be_valid
      end
      
      it 'Should have a address' do
        Fabricate.build(:person, :address => nil).should_not be_valid
      end
      
      it 'Should have a lat' do
        Fabricate.build(:person, :lat => nil).should_not be_valid
      end
      
      it 'Should have a lng' do
        Fabricate.build(:person, :lng => nil).should_not be_valid
      end
      
      it 'Weight is not required' do
        Fabricate.build(:person, :weight => nil).should be_valid
      end
      
      it 'Height is not required' do
        Fabricate.build(:person, :eight => nil).should be_valid
      end
      
      it 'Observations is not required' do
        Fabricate.build(:person, :observations => nil).should be_valid
      end    

    elsif person.current_step == 'user'

      it 'Should have a user' do
        Fabricate.build(:person, :user => nil).should_not be_valid
      end
    end
  end
end

