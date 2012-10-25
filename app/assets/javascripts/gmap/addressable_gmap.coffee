class window.AddressableGmap
  constructor: (userPosition) ->
    @coordinates = new Coordinates()

    if userPosition[0]? && userPosition[1]?
      @marker = Marker.default([userPosition[0], userPosition[1]], {draggable: true})
      Gmap.centralize([userPosition[0], userPosition[1]])
    else
      @userPosition()

    @callbacks()
    @markerEvents()
    @mapEvents()

  searchMapCoordinates: (type, address) ->
    @coordinates.getCoordinatesByAddress(type, address)

  userPosition: ->
    @marker = Marker.nonLoggedUserPosition({icon: null, draggable: true})
    $(@marker).bind 'userPositionFound', =>
      Gmap.centralize([@marker.getPosition().Ya, @marker.getPosition().Za])

  createMarker: (coordinates) ->
    @marker.setMap(null) if @marker?

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

    $(@coordinates).bind 'postalCodeSearchCoordinatesComplete', (event, result) =>
      @createMarker([result.lat, result.lng])
      $(this).trigger 'postalCodeAddressCoordinatesComplete', { result: result }

    $(@coordinates).bind 'numberSearchCoordinatesComplete', (event, result) =>
      @createMarker([result.lat, result.lng])
      $(this).trigger 'numberAddressCoordinatesComplete', { result: result }

  markerEvents: ->
    google.maps.event.addListener @marker, 'dragend', (event) =>
      @coordinates.getAddressByCoordinates(event.latLng)

  mapEvents: ->
    google.maps.event.addListener Gmap.create(), 'click', (event) =>
      @coordinates.getAddressByCoordinates(event.latLng)