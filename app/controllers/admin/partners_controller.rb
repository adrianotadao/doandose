class Admin::PartnersController < Admin::BaseController
  def index
    @partners = Partner.all
  end

  def new
    @partner = Partner.new
  end

  def show
    @partner = Partner.find_by_slug(params[:id])
  end

  def edit
    @partner = Partner.find_by_slug(params[:id])
  end

  def create
    @partner = Partner.new(params[:partner])

    if @partner.save
      redirect_to([:admin, @partner], :notice => t('flash.partner.create.notice'))
    else
      render :action => "new"
    end
  end

  def update
    @partner = Partner.find_by_slug(params[:id])
    if @partner.update_attributes(params[:partner])
      redirect_to([:admin, @partner], :notice => t('flash.partner.update.notice'))
    else
      render :action => "edit"
    end
  end

  def destroy
    @partner = Partner.find_by_slug(params[:id])
    if @partner.destroy
      redirect_to [:admin, :partners], :notice => t('flash.partner.delete.notice')
    else
      redirect_to :action => 'edit'
    end
  end
end