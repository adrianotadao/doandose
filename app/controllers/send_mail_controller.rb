class SendMailController < ApplicationController
  def create
    params[:contact]
    @contact = SendMail.new params[:contact]
    if @contact.valid?
      Mailer.contact(@contact).deliver
      render json: true
    else
      p @contact.errors
      render json: @contact.errors.messages
    end
  end
end