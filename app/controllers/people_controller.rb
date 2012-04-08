class PeopleController < ApplicationController

  def new
    @person = Person.new
  end 

  def show
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(params[:person])
    @person.blood_id = 1
    
    if @person.save
      redirect_to root_path
    else
      render :action => 'new'
    end    
  end
    
end