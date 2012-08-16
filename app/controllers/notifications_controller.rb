class NotificationsController < ApplicationController

  def index
    @notifications = Notification.all
  end

  def show
    @notification = Notification.find_by_slug params[:id]
  end

end
