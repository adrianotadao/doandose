class Admin::BaseController < ApplicationController
  protect_from_forgery
  before_filter :authenticate_admin
  layout '/layouts/admin'

  def destroy
    admin_logout
  end
end