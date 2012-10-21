class GMap
  EARTH_RADIUS = 6371
  class << self
    # GMap.distance([lat, lng], 1, 'Person')
    def elements_by_distance(point, distance, type)
      Address.where(:addressable_type => type, :loc => {"$within" => {"$centerSphere" => [point, (distance.fdiv(GMap::EARTH_RADIUS) )]}})
    end

    # GMap.distance([lat, lng], [lat, lng])
    def distance(from, to)
      latitude_distance = to[0]-from[0]
      longitude_distance = to[1]-from[1]

      latitude_distance = latitude_distance/180 * Math::PI
      longitude_distance = longitude_distance/180 * Math::PI

      lat1 = from[0]/180 * Math::PI
      lat2 = to[0]/180 * Math::PI

      x = Math.sin(latitude_distance/2) * Math.sin(latitude_distance/2) + Math.sin(longitude_distance/2) * Math.sin(longitude_distance/2) * Math.cos(lat1) * Math.cos(lat2)
      y = 2 * Math.atan2(Math.sqrt(x), Math.sqrt(1-x))

      parse_distance(GMap::EARTH_RADIUS * y)
    end

    def parse_distance(distance)
      unless distance % 2 == 1
        distance = distance.round(2)
      end

      if distance < 1
        [distance * 1000, 'm', distance]
      else
        [distance, 'km', distance]
      end
    end
  end
end