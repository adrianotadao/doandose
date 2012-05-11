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
    if @person.valid?
      case
        when params[:back_button] then @person.previous_step
        when @person.last_step? then save_person
        else @person.next_step
      end
    end
    
    session[:person_step] = @person.current_step
    new_record
  end
    
  private
    def restore_session
      @person = Person.new(session[:person_params])
      @person.current_step = session[:person_step]
    end
    
    def reset_sessions
      session[:person_step] = session[:person_params] = nil
    end

    def save_person
      @person.blood_id = 1 
      @person.save if @person.all_valid?
    end

    def new_record
      if @person.new_record?
        render 'new'
      else
        reset_sessions
        redirect_to root_path, :notice => t('flash.people.create.notice')
      end 
    end
end
