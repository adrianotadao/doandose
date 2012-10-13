module NotificationsHelper
  def participate_button(notification)
    if user_signed_in?
      participate = notification.will_participate?(current_user.authenticable)
      if participate
        link_to t('buttons.non_participate'), undo_confirm_notification_path(participate), class: 'button red'
      else
        link_to t('buttons.participate'), confirm_notification_path(notification), class: 'button red'
      end
    else
      link_to t('buttons.participate'), confirm_notification_path(notification), class: 'button red'
    end
  end
end