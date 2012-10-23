class window.Coordinates
  constructor: ->
    @geocode = new google.maps.Geocoder()

  getAddressByCoordinates: (coordinates) ->
    @geocode.geocode {
      'latLng': coordinates
    },
    (result, status) =>
      @setAddress(result) if status == 'OK'

  getCoordinatesByAddress: (type, address) ->
    @geocode.geocode {
      address: address
    },
    (result, status) =>
      @setCoordinates(type, result) if status == 'OK'

  setCoordinates: (type, result) =>
    $(this).trigger("#{type}SearchCoordinatesComplete", $.extend({ address: result[0] }, @parseCoordinates(result)))

  setAddress: (result) =>
    $(this).trigger('searchAddressComplete', $.extend({ address: result[0] }, @parseCoordinates(result)))

  parseCoordinates: (result) ->
    return { lat: result[0].geometry.location.Xa, lng: result[0].geometry.location.Ya}