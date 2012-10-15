class window.AddressableGmap
  constructor: (options) ->
    @coordinates = new Coordinates()

    if options.lat != '' && options.lng != ''
      @coordinates.getAddressByCoordinates(@parseLatLng({ lat: options.lat, lng: options.lng }))

    @callbacks()
    @userPosition()
    @markerEvents()
    @mapEvents()

  searchMapCoordinates: (address) ->
    @coordinates.getCoordinatesByAddress(address)

  userPosition: ->
    @marker = Marker.nonLoggedUserPosition({icon: null, draggable: true})
    $(@marker).bind 'userPositionFound', =>
      @coordinates.getAddressByCoordinates(@marker.getPosition())

  createMarker: (coordinates) ->
    Gmap.removeAllMarkers()

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