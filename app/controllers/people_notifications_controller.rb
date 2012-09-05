class PeopleNotificationsController < ApplicationController
  def index
    @peoplenotifications = PeopleNotification.all
  end

  def show
    @peoplenotification = PeopleNotification.find params[:people_notification]
  end
end