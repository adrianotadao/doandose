class GmapController < ApplicationController
  def elements_by_user_position
    position = [params[:position][:lat].to_f, params[:position][:lng].to_f]
    distance = params[:distance].to_i
    blood_types = params[:blood_types]

    @companies = GMap.elements_by_distance(position, distance, 'Company').map(&:addressable).map do |r|
      {id: r.id, lat: r.address.loc[0], lng: r.address.loc[1] }
    end

    @people = GMap.elements_by_distance(position, distance, 'Person').map(&:addressable).map do |r|
      if blood_types
        if r.blood.name.in? blood_types
          {id: r.id, lat: r.address.loc[0], lng: r.address.loc[1] }
        end
      else
        {id: r.id, lat: r.address.loc[0], lng: r.address.loc[1] }
      end
    end

    render json: { people: @people.compact, companies: @companies.compact}
  end
end