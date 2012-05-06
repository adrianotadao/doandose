class PeopleController < ApplicationController

  def new
    session[:person_params] ||= {}
    restore_session
  end 

  def show
    @person = Person.find(params[:id])
  end

  def create
    session[:person_params].deep_merge!(params[:person]) if params[:person]
    restore_session

    if params[:back_button]
      @person.previous_step
    elsif @person.last_step?
      @person.blood_id = 1 
      @person.save 
    else
      @person.next_step
    end
    session[:person_step] = @person.current_step

    if @person.new_record?
      render 'new'
    else
      flash[:notice] = 'cadastro efetuado com sucesso'
      redirect_to root_path
    end  
  end
    
  private
    def restore_session
      @person = Person.new(session[:person_params])
      @person.current_step = session[:person_step]
    end
end
