class PeopleController < ApplicationController

  def new
    @person = Person.new
  end 

  def create
    @person = Person.new
  end
    
end
