class SendMailController < ApplicationController
  def create
    @contact = SendMail.new params[:contact]

    if @contact.valid?
      Mailer.contact(@contact).deliver
      render json: true
    else
      render json: @contact.errors.messages
    end
  end
end