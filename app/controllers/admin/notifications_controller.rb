class Admin::NotificationsController < Admin::BaseController
  def index
    @notifications = Notification.all
  end

  def new
    @notification = Notification.new
  end

  def show
    @notification = Notification.find_by_slug(params[:id])
  end

  def edit
    @notification = Notification.find_by_slug(params[:id])
  end

  def create
    @notification = Notification.new(params[:notification])

    if @notification.save
      redirect_to([:admin, @notification], :notice => 'Partner criada com sucesso.')
    else
      render :action => "new"
    end
  end

  def update
    @notification = Notification.find_by_slug(params[:id])

    if @notification.update_attributes(params[:notification])
      redirect_to([:admin, @notification], :notice => 'Partner editada com sucesso.')
    else
      render :action => "edit"
    end
  end

  def destroy
    if @partner.destroy
      redirect_to [:admin, :categories], :notice => "Partner deletada com sucesso!"
    else
      redirect_to :action => 'edit'
    end
  end
end