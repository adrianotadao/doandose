class Admin::CampaignsController < Admin::BaseController

  def index
    @campaigns = Campaign.all
  end

  def show
    @campaign = Campaign.find_by_slug params[:id]
  end

  def new
      @campaign = Campaign.new
      @bloods = Blood.scoped.to_a.map(&:id)
  end

  def create
    @bloods = Blood.scoped.to_a.map(&:id)
    @campaign = Campaign.new params[:campaign]
    if @campaign.save
      redirect_to admin_campaigns_path
    else
      render 'new'
    end
  end

  def edit
    @bloods = Blood.scoped.to_a.map(&:name)
    @campaign = Campaign.find_by_slug params[:id]
  end

  def update
    @bloods = Blood.scoped.to_a.map(&:name)
    @campaign = Campaign.find_by_slug params[:id]

    if @campaign.update_attributes params[:campaign]
      redirect_to edit_admin_campaigns_path
    else
      render 'edit'
    end
  end

  def destroy
    	p params[:campaign]
      @campaign = Campaign.find_by_slug params[:campaign]

 	p @campaign
      if @campaign.destroy
        redirect_to admin_campaigns_path
      end
  end
end
