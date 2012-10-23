class Admin::PeopleController < Admin::BaseController
  def index
    @people = Person.all
  end

  def new
    @person = Person.new
    @bloods = Blood.scoped.map{ |b| [b.name, b.id] }
  end

  def show
    @person = Person.find_by_slug(params[:id])
  end

  def edit
    @person = Person.find_by_slug(params[:id])
    @bloods = Blood.scoped.map{ |b| [b.name, b.id] }
  end

  def create
    @bloods = Blood.scoped.map{ |b| [b.name, b.id] }
    @person = Person.new(params[:person])

    if @person.save
      redirect_to([:admin, :people], :notice => t('flash.person.create.notice'))
    else
      render :action => "new"
    end
  end

  def update
    @bloods = Blood.scoped.map{ |b| [b.name, b.id] }
    @person = Person.find_by_slug(params[:id])
    if @person.update_attributes(params[:person])
      redirect_to([:admin, @person], :notice => t('flash.person.update.notice'))
    else
      render :action => "edit"
    end
  end

  def destroy
    @person = Person.find_by_slug(params[:id])
    if @person.destroy
      redirect_to [:admin, :people], :notice => t('flash.person.delete.notice')
    else
      redirect_to :action => 'edit'
    end
  end
end