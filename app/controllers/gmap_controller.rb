class GmapController < ApplicationController
  def elements_by_user_position
    position = [params[:positions][:lat].to_f, params[:positions][:lng].to_f]

    @companies = GMap.elements_by_distance(position, 5, 'Company').map(&:addressable).map{|r| [r.address.loc[0], r.address.loc[1]]}
    @people = GMap.elements_by_distance(position, 5, 'Person').map(&:addressable).map{|r| [r.address.loc[0], r.address.loc[1]]}

    render json: { people: @people, companies: @companies}
  end
end