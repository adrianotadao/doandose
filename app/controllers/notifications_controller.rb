class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all
  end

  def confirm
    @notification = Notification.find_by_slug params[:id]
    @person = Person.first
    @person_notification = @notification.person_notifications.new
  end

  def confirmed
    @person = Person.first
    @notification = Notification.find_by_slug params[:id]
    person_id =  params[:person_notification][:person_id]

    if @notification.person_notifications.is_confimed( person_id ).exists?
      redirect_to notifications_path
    else
      save_confirmed_notification
    end
  end

  private
    def save_confirmed_notification
      @person_notification = @notification.person_notifications.new params[:person_notification]

      if @person_notification.save
        redirect_to notifications_path
      else
        render 'confirm'
      end
    end
end