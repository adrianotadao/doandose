class Admin::PeopleController < Admin::BaseController
  def index
    @people = Person.all
  end

  def show
    @person = Person.find_by_slug params[:id]
  end

  def edit
    @person = Person.find_by_slug params[:id]
  end

  def update
    @person = Person.find_by_slug params[:id]

    if @person.update_attributes params[:person]
      update_user_cookie @person.user
      redirect_to([:admin, @person], :notice => t('flash.person.update.notice'))
    else
      render :action => "edit"
    end
  end

  def destroy
    @person = Person.find_by_slug params[:id]
    if @person.destroy
      redirect_to [:admin, :people], :notice => t('flash.person.delete.notice')
    else
      redirect_to :action => 'edit'
    end
  end
end