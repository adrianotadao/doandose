class Admin::BloodsController < Admin::BaseController
  def index
    @bloods = Blood.all
  end
  
  def show
    @blood = Blood.find(params[:id])
  end
end