class GmapController < ApplicationController
  def find_elements_to_map
    position = [params[:position][:lat].to_f, params[:position][:lng].to_f]
    distance = params[:distance].to_i
    blood_types = params[:blood_types]
    type = params[:type]
    @people = []
    @companies = []

    if type == 'company'
      @companies = GMap.elements_by_distance(position, distance, 'Company').map(&:addressable).map do |r|
        {id: r.id, lat: r.address.loc[0], lng: r.address.loc[1] }
      end
    end

    if type == 'person'
      @people = GMap.elements_by_distance(position, distance, 'Person').map(&:addressable).map do |r|
        if blood_types
          if r.blood.name.in? blood_types
            {id: r.id, lat: r.address.loc[0], lng: r.address.loc[1] }
          end
        else
          {id: r.id, lat: r.address.loc[0], lng: r.address.loc[1] }
        end
      end
    end
    render json: { people: @people.compact, companies: @companies.compact}
  end

  def find_elements_to_notification
    position = [params[:position][:lat].to_f, params[:position][:lng].to_f]
    distance = params[:distance].to_i
    blood_types = BloodMatch.receives params[:blood]

    @people = GMap.elements_by_distance(position, distance, 'Person')

    @collectedPeople = @people.map(&:addressable).map do |r|
      if blood_types
        last_participation = r.alerts.participateds.last
        next if last_participation && (last_participation.created_at + 3.months) > Time.now

        if r.blood.name.in? blood_types
          {
            id: r.id,
            name: r.name,
            blood: r.blood.name,
            address: r.address.formated_address,
            lat: r.address.loc[0],
            lng: r.address.loc[1],
            distance: GMap.distance(position, [r.address.loc[0], r.address.loc[1]])
          }
        end
      end
    end

    render json: {
      people: @collectedPeople.compact.sort_by{|r| r[:distance][2]},
      counters: @collectedPeople.compact.group_by{|r| r[:blood]}.map{|k,v| [k, v.length]}
    }
  end
end