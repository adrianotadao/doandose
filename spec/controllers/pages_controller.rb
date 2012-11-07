require 'spec_helper'

describe PagesController do
  describe 'GET :index' do
    get :index
    response.should be_success
  end
end