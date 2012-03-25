class PagesController < ApplicationController
  def index
    @person = Person.new
    @person.build_address if @person.address blank?
    @person.build_user
    @person.build_contact if @person.contact blank?
  end 

end
