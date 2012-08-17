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
      redirect_to admin_campaigns_path
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
  		redirect_to edit_admin_campaigns_path
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@campaign = Campaign.find_by_slug params[:campaign]
 		@campaign.destroy
  end
end
