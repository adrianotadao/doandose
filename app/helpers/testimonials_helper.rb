module TestimonialsHelper
  def sort_by_testimonial
    Testimonial.actives.sort_by{rand()}.map(&:body).first
  end
end