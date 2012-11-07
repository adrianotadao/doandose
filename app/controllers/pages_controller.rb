class PagesController < ApplicationController
  layout 'iframe', only: :about_us

  def indexx
    @people_coordinates = Address.people.map{|r| [r.loc[0], r.loc[1]] if r.loc? }.compact
    @companies_coordinates = Address.companies.map{|r| [r.loc[0], r.loc[1]] if r.loc? }.compact
  end

  def about_us
  end
end