class Admin::NotificationsController < Admin::BaseController
  def index
    @notifications = Notification.all
  end

  def new
    @notification = Notification.new
  end

  def show
    @notification = Notification.find_by_slug params[:id]
  end

  def edit
    @bloods = Blood.scoped.map{ |b| [b.name, b.id] }
    @notification = Notification.find_by_slug params[:id]
  end

  def create
    @notification = Notification.new params[:notification]

    position = @notification.company.address.loc
    blood_types = BloodMatch.receives @notification.blood.name

    if blood_types
      people = GMap.elements_by_distance(position, 40, 'Person').map(&:addressable)

      for person in people
        last_participation = person.alerts.participateds.last
        next if last_participation && (last_participation.created_at + 3.months) > Time.now
        if person.blood.name.in? blood_types
          @notification.person_notifications.new person: person
        end
      end
    end

    if @notification.valid?
      if @notification.save
        redirect_to([:admin, :notifications], :notice => t('flash.notification.create.notice'))
      else
        render action: 'new'
      end
    else
      render action: :new
    end

  end

  def update
    @notification = Notification.find_by_slug params[:id]

    if @notification.update_attributes params[:notification]
      redirect_to([:admin, @notification], :notice => t('flash.notification.update.notice'))
    else
      render :action => "edit"
    end
  end

  def destroy
    @notification = Notification.find_by_slug(params[:id])

    if @notification.destroy
      redirect_to [:admin, :notifications], :notice => t('flash.notification.delete.notice')
    else
      redirect_to :action => 'edit'
    end
  end
end