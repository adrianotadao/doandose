class GMap
  class << self
    def initializer
    end

    #number street_name, neighborhood, City - State
    def coordinates(address)
      Geokit::Geocoders::GoogleGeocoder.geocode(address)
    end

    def user_booble(user)
    end

    def user_route(x_point, y_point)
    end

    def users_in_booble(users)
    end

    def users_in(distance)
    end

    def address_by_postal_code(postal_code)
    end
  end
end