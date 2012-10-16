class GmapController < ApplicationController
  def elements_by_user_position
    position = [params[:positions][:lat].to_f, params[:positions][:lng].to_f]

    @companies = GMap.elements_by_distance(position, 5, 'Company').map(&:addressable).map do |r|
      {id: r.id, lat: r.address.loc[0], lng: r.address.loc[1] }
    end

    @people = GMap.elements_by_distance(position, 5, 'Person').map(&:addressable).map do |r|
      {id: r.id, lat: r.address.loc[0], lng: r.address.loc[1] }
    end

    render json: { people: @people, companies: @companies}
  end
end