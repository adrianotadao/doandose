class Institution::PersonNotificationsController < Institution::BaseController
  def show
    @person_notification = PersonNotification.find(params[:id])
  end
end