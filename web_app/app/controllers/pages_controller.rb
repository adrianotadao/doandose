class PagesController < ApplicationController
  def index
    @person = Person.new
  end 

end
