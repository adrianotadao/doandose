class PagesController < ApplicationController
  def index
    @coordinates = Address.scoped.map{|r| [r.lat, r.lng]}
  end
end