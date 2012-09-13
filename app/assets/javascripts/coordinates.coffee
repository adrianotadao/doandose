class window.Coordinates
  getCoordinates: (address) ->
    new google.maps.Geocoder().geocode {
      address: address
    },
    (result, status) =>
      @setCoordinates(result) if status == 'OK'

  parseCoordinates: (result) ->
    return result[0].geometry.location

  setCoordinates: (result) =>
    $(this).trigger('searchCoordinatesComplete', { lat: @parseCoordinates(result).Xa, lng: @parseCoordinates(result).Ya})