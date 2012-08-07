class PartnersController < ApplicationController
  def index
    @partners = Partner.all.to_a
  end

  def show
    @partner = Partner.find_by_slug params[:id]
  end
end