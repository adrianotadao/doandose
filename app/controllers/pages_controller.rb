class PagesController < ApplicationController
  def index
    @people_coordinates = Address.people.map{|r| [r.lat, r.lng]}
    @companies_coordinates = Address.companies.map{|r| [r.lat, r.lng]}
  end
end