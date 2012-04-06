class PeopleController < ApplicationController

  def new
    @person = Person.new
    @user = User.new
  end 

  def show
    @person = Person.find params[:id]
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
