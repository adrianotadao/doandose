class Admin::CompaniesController < Admin::BaseController
  def index
    @companies = Company.all
  end
  
  def new
    @company = Company.new
  end
  
  def show
    @company = Company.find_by_slug(params[:id])
  end

  def edit
    @company = Company.find_by_slug(params[:id])
  end
  
  def create
    @company = Company.new(params[:company])

    if @company.save
      redirect_to([:admin, @company], :notice => 'Company criada com sucesso.')
    else
      render :action => "new"
    end
  end

  def update
    @company = Company.find_by_slug(params[:id])

    if @company.update_attributes(params[:company])
      redirect_to([:admin, @company], :notice => 'Company editada com sucesso.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @company = Company.find_by_slug(params[:id])

    if @company.destroy
      redirect_to [:admin, :companies], :notice => "Company deletada com sucesso!"
    else
      redirect_to :action => 'edit'
    end
  end
end