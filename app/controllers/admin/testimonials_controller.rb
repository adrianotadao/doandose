class Admin::TestimonialsController < Admin::BaseController
  def index
    @testimonials = Testimonial.scoped
  end

  def edit
    @testimonial = Testimonial.find_by_slug params[:id]
    p @testimonial
  end

  def update
    @testimonial = Testimonial.find_by_slug params[:id]

    if @testimonial.update_attributes params[:testimonial]
      redirect_to([:admin, :testimonials])
    else
      render :action => "edit"
    end
  end

  def destroy
    @testimonial = Testimonial.find_by_slug(params[:id])

    if @testimonial.destroy
      redirect_to [:admin, :testimonials], :notice => t('flash.notification.delete.notice')
    else
      redirect_to :action => 'edit'
    end
  end
end