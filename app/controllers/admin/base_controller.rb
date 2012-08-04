class Admin::BaseController < ApplicationController
  protect_from_forgery
  before_filter :authenticate_admin
  layout '/layouts/admin'
end