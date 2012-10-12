class window.AddressableGmap
  constructor: (options) ->
    @coordinates = new Coordinates()
    @marker = undefined

    if options.lat != '' && options.lng != ''
      @coordinates.getAddressByCoordinates(@parseLatLng({ lat: options.lat, lng: options.lng }))

    @mapEvents()
    @callbacks()

    Marker.nonLoggedUserPosition()

  searchMapCoordinates: (address) ->
    @coordinates.getCoordinatesByAddress(address)

  createMarker: (coordinates) ->
    @destroyMarker()

    @marker = Marker.default(coordinates, {draggable: true})

    Gmap.centralize(coordinates)
    @markerEvents()

  destroyMarker: ->
    @marker.setMap(null) unless @marker == undefined

  parseLatLng: (coodinates) ->
    return new google.maps.LatLng(coodinates.lat, coodinates.lng)

  callbacks: ->
    $(@coordinates).bind 'searchAddressComplete', (event, result) =>
      @createMarker([result.lat, result.lng])
      $(this).trigger 'addressComplete', { result: result }

    $(@coordinates).bind 'searchCoordinatesComplete', (event, result) =>
      @createMarker([result.lat, result.lng])
      $(this).trigger 'addressCoordinatesComplete', { result: result }

  markerEvents: ->
    google.maps.event.addListener @marker, 'dragend', (event) =>
      @coordinates.getAddressByCoordinates(event.latLng)

  mapEvents: ->
    google.maps.event.addListener Gmap.create(), 'click', (event) =>
      @coordinates.getAddressByCoordinates(event.latLng)