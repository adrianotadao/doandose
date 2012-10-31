class Admin::BloodsController < Admin::BaseController
  def index
    @bloods = Blood.all
  end

  def new
    @blood = Blood.new
  end

  def edit
    @blood = Blood.find_by_slug params[:id]
  end

  def create
    @blood = Blood.new params[:blood]

    if @blood.save
      redirect_to [:admin, :bloods], :notice => t('flash.blood.create.notice')
    else
      render :action => "new"
    end
  end

  def update
    @blood = Blood.find_by_slug params[:id]

    if @blood.update_attributes(params[:blood])
      redirect_to [:admin, :bloods], :notice => t('flash.blood.update.notice')
    else
      render :action => "edit"
    end
  end

  def destroy
    @blood = Blood.find_by_slug params[:id]
    @blood.destroy
    redirect_to [:admin, :bloods], :notice => t('flash.blood.delete.notice')
  end
end