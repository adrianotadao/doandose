class NotificationsController < ApplicationController
  layout '/layouts/print', only: :print
  before_filter :authenticate_user!, only: [:confirm, :confirmed, :undo_confirm]

  def index
    if user_signed_in?
      @notifications = Notification.actives.compatibles_by(Blood.where(:name.in => BloodMatch.donor(current_user.authenticable.blood.name)).map(&:id)).paginate(:page => params[:page])
    else
      @notifications = Notification.actives.paginate(:page => params[:page])
    end
  end

  def show
    @notification = Notification.find_by_slug params[:id]
    @qr_code = RQRCode::QRCode.new( notification_url(@notification), :size => 10, leve: :l )
  end

  def confirm
    @notification = Notification.find_by_slug params[:id]
    @person = current_user.authenticable
    @person_notification = @notification.person_notifications.new
  end

  def confirmed
    @person = current_user.authenticable
    @notification = Notification.find_by_slug params[:id]

    if @notification.notification_confirmed( current_user.authenticable.id )
      update_notification_canceled
      redirect_to notifications_path
    else
      save_confirmed_notification
    end
  end

  def undo_confirm
    @notification = Notification.find_by_slug(params[:id])
    @person_notification = @notification.will_participate(current_user.authenticable)
    if @person_notification.update_attributes(canceled_at: Time.now)
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
    @send_indication = IndicationFriend.new params[:indication_friend]

    if @send_indication.valid?
      Mailer.indication_friend(@send_indication).deliver
      redirect_to notification_path(@notification)
    else
      render action: 'indication_friend'
    end
  end

  def print
    @notification = Notification.find_by_slug params[:notification_id]
    @qr_code = RQRCode::QRCode.new( notification_url(@notification), :size => 10, leve: :l )
  end

  private
    def save_confirmed_notification
      @person_notification = @notification.person_notifications.new params[:person_notification]

      if @person_notification.save
        redirect_to notification_path(@notification)
      else
        p @person_notification.errors
        render action: 'confirm'
      end
    end

    def update_notification_canceled
      @person_notification = @notification.will_participate(current_user.authenticable)

      if @person_notification.canceled?
        @person_notification.update_attributes(canceled_at: '')
      end
    end
end