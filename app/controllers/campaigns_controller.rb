class CampaignsController < ApplicationController
  layout '/layouts/print', only: :print
  before_filter :authenticate_user!, only: [:confirmed, :undo_confirm]

  def index
    if user_signed_in?
      @campaigns = Campaign.actives.compatibles_by(Blood.where(:name.in => BloodMatch.donor(current_user.authenticable.blood.name)).map(&:id)).paginate(per_page: 15, page: params[:page])
    else
      @campaigns = Campaign.scoped.paginate(per_page: 15, page: params[:page])
    end
  end

  def confirmed
    @person = current_user.authenticable
    @campaign = Campaign.find_by_slug params[:id]

    if @campaign.campaign_confirmed( current_user.authenticable.id )
      redirect_to campaigns_path
    else
      save_confirmed_campaign
    end
  end

  def undo_confirm
    @person_campaign= PersonCampaign.find(params[:id])
    if @person_campaign.update_attributes(canceled_at: Time.now)
      redirect_to campaigns_path
    end
  end

  def show
    @campaign = Campaign.find_by_slug params[:id]
    @person = current_user.authenticable
    @person_campaign = @campaign.person_campaigns.new
    @qr_code = RQRCode::QRCode.new( campaign_url(@campaign), :size => 10, leve: :l )
  end

  def print
    @campaign = Campaign.find_by_slug params[:campaign_id]
    @qr_code = RQRCode::QRCode.new( campaign_url(@campaign), :size => 10, leve: :l )
  end

  private
  def save_confirmed_campaign
    @person_campaign = @campaign.person_campaigns.new params[:person_campaign]

    if @person_campaign.save
      redirect_to campaign_path(@campaign)
    else
      render action: 'index'
    end
  end
end