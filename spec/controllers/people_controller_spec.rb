require 'spec_helper'

describe PeopleController do
  describe 'GET :new' do
    context 'user logged' do
      it 'should redirect to edit profile path' do
        person = FactoryGirl.create(:person)
        login person.user

        get :new
        response.should redirect_to(edit_person_path(person))
      end
    end

    context 'user non logged' do
      it 'should render the new template' do
        logout

        get :new
        response.should render_template('new')
      end

      it 'should have the @people variable' do
        logout

        get :new
        assigns[:person].should_not be_nil
      end
    end
  end

  describe 'GET :show' do
    it 'should render the show template' do
      person = FactoryGirl.create(:person)
      login person.user

      get :show, { id: person.slug }
      response.should render_template('show')
    end

    it 'should redirect if user non logged' do
      person = FactoryGirl.create(:person)
      logout

      get :show, { id: person.slug }
      response.should redirect_to(users_new_session_path)
    end
  end

  describe 'GET :show' do
    it 'should render the show template' do
      person = FactoryGirl.create(:person)
      login person.user

      get :show, { id: person.slug }
      response.should render_template('show')
    end

    it 'should redirect if user non logged' do
      person = FactoryGirl.create(:person)
      logout

      get :show, { id: person.slug }
      response.should redirect_to(users_new_session_path)
    end
  end

  describe 'GET :edit' do
    it 'should render the edit template' do
      person = FactoryGirl.create(:person)
      login person.user

      get :edit, { id: person.slug }
      response.should render_template('edit')
    end

    it 'should redirect if user non logged' do
      person = FactoryGirl.create(:person)
      logout

      get :edit, { id: person.slug }
      response.should redirect_to(users_new_session_path)
    end
  end

end