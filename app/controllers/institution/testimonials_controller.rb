class Institution::TestimonialsController < Institution::BaseController
  def index
    @testimonials = current_user.authenticable.testimonials
  end

  def new
    @testimonial = Testimonial.new
  end

  def edit
    @testimonial = Testimonial.find_by_slug params[:id]
  end

  def create
    @testimonial = Testimonial.new params[:testimonial]
    @testimonial.company_id = current_user.authenticable

    if @testimonial.save
      redirect_to([:institution, :testimonials])
    else
      p @testimonial.errors
      render action: 'new'
    end
  end

  def update
    @testimonial = Testimonial.find_by_slug params[:id]

    if @testimonial.update_attributes params[:testimonial]
      redirect_to([:institution, :testimonials])
    else
      render :action => "edit"
    end
  end
end