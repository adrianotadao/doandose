class Institution::PersonNotificationsController < Institution::BaseController
  def show
    @person_notification = PersonNotification.find params[:id]
  end

  def participation
    @person_notification = PersonNotification.find params[:id]
    @person_notification.update_attributes(participated: params[:participated])
    render nothing: true
  end

end