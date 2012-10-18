class Institution::BaseController < ApplicationController
  layout '/layouts/institution'

  def destroy
    logout_company
  end
end