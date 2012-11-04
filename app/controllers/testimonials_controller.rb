class TestimonialsController < ApplicationController
  def index
    @testimonials = Testimonial.actives.paginate( per_page: 16, page: params[:page])
  end
end