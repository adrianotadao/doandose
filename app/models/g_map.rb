class GMap
  class << self
    def elements_by_distance(point, distance, type)
      earthRadius = 6371 #km
      Address.where(:addressable_type => type, :loc => {"$within" => {"$centerSphere" => [point, (distance.fdiv(earthRadius) )]}})
    end
  end
end