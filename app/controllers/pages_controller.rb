class PagesController < ApplicationController
  def index
    @addresses = Address.scoped
  end
end