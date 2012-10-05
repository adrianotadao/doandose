class PagesController < ApplicationController
  def index
    @people_coordinates = Address.people.map{|r| [r.loc[0], r.loc[1]] if r.loc? }.compact
    @companies_coordinates = Address.companies.map{|r| [r.loc[0], r.loc[1]] if r.loc? }.compact
  end
end