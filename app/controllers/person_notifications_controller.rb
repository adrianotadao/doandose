class PersonNotificationsController < ApplicationController
  def index
    @peoplenotifications = PeopleNotification.all
  end

  def show
    @peoplenotification = PeopleNotification.find params[:people_notification]
  end
  
  def canceling
    @people_notification = PeopleNotification.find params[:id]
    @people_notification.update_attributes(canceled_at: Time.now)
  end
end