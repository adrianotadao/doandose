require 'spec_helper'

describe User do
  it 'Should have a valid user' do
    FactoryGirl.build(:user).should be_valid
  end

  context 'Email' do
    it 'should be uniq' do
      user = FactoryGirl.create(:user)
      FactoryGirl.build(:user, email: user.email).should_not be_valid
    end

    it 'must have a email format' do
      FactoryGirl.build(:user, email: 'foo').should_not be_valid
      FactoryGirl.build(:user, email: 'foo@bar.com.br').should be_valid
    end
  end

  context 'Should have this methods' do
    it 'create_with_omniauth' do
      User.should respond_to :create_with_omniauth
    end

    it 'parse_omniauth' do
      User.should respond_to :parse_omniauth
    end

    it 'social_networks' do
      User.should respond_to :social_networks
    end

    it 'define_gender' do
      User.should respond_to :define_gender
    end

    it 'locate' do
      User.should respond_to :locate
    end

    it 'build_identity' do
      FactoryGirl.build(:user).should respond_to :build_identity
    end

    it 'authentications?' do
      FactoryGirl.build(:user).should respond_to :authentications?
    end

    it 'add_authentication' do
      FactoryGirl.build(:user).should respond_to :add_authentication
    end

    it 'prepare_to_reset_password!' do
      FactoryGirl.build(:user).should respond_to :prepare_to_reset_password!
    end

    it 'password_is_reseted!' do
      FactoryGirl.build(:user).should respond_to :password_is_reseted!
    end

    it 'generate_token!' do
      FactoryGirl.build(:user).should respond_to :generate_token!
    end
  end
end