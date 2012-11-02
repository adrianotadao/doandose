class Admin::StatisticsController < Admin::BaseController
  def index
  end

  def subscribe_per_date
    render :json => Statistically.amount_of_blood_type(params[:start_at].to_i.weeks.ago, params[:end_at].to_i.weeks.ago)
  end
end