class Institution::BaseController < ApplicationController
  before_filter :authenticate_user!
  layout '/layouts/institution'
end