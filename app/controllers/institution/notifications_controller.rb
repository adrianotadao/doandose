class Institution::NotificationsController < Institution::BaseController
  def index
    @notifications = Notification.all
  end

  def new
    @notification = Notification.new
    @bloods = Blood.scoped
  end

  def show
    @notification = Notification.find_by_slug(params[:id])
  end

  def create
    @notification = Notification.new params[:notification]
    @notification.company = current_institution.authenticable
    @notification.blood = Blood.where( name: @notification.blood_type).first

    position = current_institution.authenticable.address.loc
    blood_types = BloodMatch.matcher @notification.blood_type

    if blood_types
      GMap.elements_by_distance(position, @notification.distance.to_i, 'Person').map(&:addressable).map do |person|
        if person.blood.name.in? blood_types
          @notification.person_notifications.new person: person
        end
      end
    end

    if @notification.valid?
      if @notification.save
        redirect_to([:institution, :notifications], :notice => t('flash.notification.create.notice'))
      else
        render action: :new
      end
    else
      render action: :new
    end
  end

  def destroy
    @notification = Notification.find_by_slug(params[:id])

    if @notification.destroy
      redirect_to [:institution, :notifications], :notice => t('flash.notification.delete.notice')
    else
      redirect_to :action => 'edit'
    end
  end
end