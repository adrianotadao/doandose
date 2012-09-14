class window.Coordinates
  constructor: ->
    @geocode = new google.maps.Geocoder()

  getAddressByCoordinates: (coordinates) ->
    @geocode.geocode {
      'latLng': coordinates
    },
    (result, status) =>
      @setAddress(result) if status == 'OK'

  getCoordinatesByAddress: (address) ->
    @geocode.geocode {
      address: address
    },
    (result, status) =>
      @setCoordinates(result) if status == 'OK'

  parseCoordinates: (result) ->
    return result[0].geometry.location

  setCoordinates: (result) =>
    $(this).trigger('searchCoordinatesComplete', { lat: @parseCoordinates(result).Xa, lng: @parseCoordinates(result).Ya})

  setAddress: (result) =>
    $(this).trigger('searchAddressComplete', { address: result[0].formatted_address })