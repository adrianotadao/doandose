class Institution::CampaignsController < Institution::BaseController

  def index
    @campaigns = current_user.authenticable.campaigns
  end

  def show
    @campaign = Campaign.find_by_slug params[:id]
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new params[:campaign]
    @campaign.company_id = current_user.authenticable

    participants_choose

    if @campaign.save
      redirect_to([:institution, :campaigns], :notice => t('flash.campaign.create.notice'))
    else
      render action: :new
    end
  end

  def edit
    @campaign = Campaign.find_by_slug params[:id]
  end

  def update
    @campaign = Campaign.find_by_slug params[:id]

    if @campaign.update_attributes params[:campaign]
      redirect_to institution_campaigns_path
    else
      render 'edit'
    end
  end

  private
    def participants_choose
      position = current_user.authenticable.address.loc
      blood_types = BloodMatch.receives @campaign.blood.name

      if blood_types
        people = GMap.elements_by_distance(position, 40, 'Person').map(&:addressable)
        for person in people
          last_participation = person.alerts.participateds.last
          next if last_participation && (last_participation.created_at + 3.months) > Time.now
          if person.blood.name.in? blood_types
            @campaign.person_campaigns.new person: person
          end
        end
      end
    end
end