class NotificationsController < ApplicationController
  def index
    @notifications = Notification.actives
  end

  def show
    @notification = Notification.find_by_slug params[:id]
  end

  def confirm
    @notification = Notification.find_by_slug params[:id]
    @person = current_user.authenticable
    @person_notification = @notification.person_notifications.new
  end

  def confirmed
    @person = current_user.authenticable
    @notification = Notification.find_by_slug params[:id]

    if @notification.person_notifications.is_confimed( @person.id ).exists?
      redirect_to notifications_path
    else
      save_confirmed_notification
    end
  end

  def undo_confirm
    @person_notification = PersonNotification.find(params[:id])

    if @person_notification.destroy
      redirect_to notifications_path
    end
  end

  private
    def save_confirmed_notification
      p params
      @person_notification = @notification.person_notifications.new params[:person_notification]

      if @person_notification.save
        redirect_to notifications_path
      else
        render 'confirm'
      end
    end
end