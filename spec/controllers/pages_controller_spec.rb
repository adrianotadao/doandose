require 'spec_helper'

describe PagesController do
  describe 'GET :index' do
    it 'should have the @people_coordinates variable' do
      get :index
      assigns[:people_coordinates].should_not be_nil
    end

    it 'should have the @companies_coordinates variable' do
      get :index
      assigns[:companies_coordinates].should_not be_nil
    end

    it 'renders the index template' do
      get :index
      response.should render_template('index')
    end
  end

  describe 'GET :about_us' do
    it 'renders the about_us template' do
      get :about_us
      response.should render_template('about_us')
    end
  end
end