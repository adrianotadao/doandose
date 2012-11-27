class Admin::CampaignsController < Admin::BaseController

  def index
    @campaigns = Campaign.all
  end

  def show
    @campaign = Campaign.find_by_slug params[:id]
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new params[:campaign]

    if @campaign.save
      redirect_to admin_campaigns_path, notice: t('flash.campaign.create.notice')
    else
      render 'new'
    end
  end

  def edit
    @campaign = Campaign.find_by_slug params[:id]
  end

  def update
    @campaign = Campaign.find_by_slug params[:id]

    if @campaign.update_attributes params[:campaign]
      redirect_to admin_campaigns_path, notice: t('flash.campaign.update.notice')
    else
      render 'edit'
    end
  end

  def destroy
      @campaign = Campaign.find_by_slug params[:id]
      if @campaign.destroy
        redirect_to admin_campaigns_path, notice: t('flash.campaign.delete.notice')
      end
  end
end
