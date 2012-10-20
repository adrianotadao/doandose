class NotificationsController < ApplicationController
  before_filter :authenticate_user!, only: [:confirm, :confirmed, :undo_confirm]

  def index
    @notifications = Notification.actives.paginate(:page => params[:page])
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

  def list_user
    @notification = Notification.find_by_slug params[:notification_id]
    @person_notifications = @notification.person_notifications
  end

  def indication_friend
    @notification = Notification.find_by_slug params[:id]
    @send_indication = IndicationFriend.new
  end

  def send_indication
    @notification = Notification.find_by_slug params[:id]
    @indication_friend = IndicationFriend.new params[:indication_friend]

    if @indication_friend.valid?
      Mailer.indication_friend(@indication_friend).deliver
      redirect_to notification_path(@notification)
    else
      redirect_to indication_friend_notification_path
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