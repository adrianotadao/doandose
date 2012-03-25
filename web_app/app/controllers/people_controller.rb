class PeopleController < ApplicationController

  def new
    @person = Person.new
  end 

  def create
    @person = Person.new
    if @person.save
      redirect_to root_path
    else
      render :action => 'new'
    end    
  end
    
end
