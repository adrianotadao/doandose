class Institution::PersonNotificationsController < Institution::BaseController
  before_filter :find_person_notification

  def show
  end

  def participation
    @person_notification.update_attributes(participated: params[:participated])
    render nothing: true
  end

  def send_sms
    if @person_notification.can_send_sms
      Resque.enqueue(PersonNotifications::SMS, @person_notification.id)
      flash[:notice] = 'email enviado com sucesso !!!'
    else
      flash[:notice] = 'Ja foi disparado um email para este usuario. Aguarde 1 hr.'
    end
    render nothing: true
  end

  def send_email
    if @person_notification.can_send_email
      Resque.enqueue(PersonNotifications::Email, @person_notification.id)
      flash[:notice] = 'sms enviado com sucesso !!!'
    else
      flash[:notice] = 'Ja foi disparado um sms para este usuario. Aguarde 1 hr.'
    end
    render nothing: true
  end

  private
  def find_person_notification
    @person_notification = PersonNotification.find params[:id]
  end

end