class window.AddressableGmap extends GmapBase
  constructor: (options) ->
    super(options)
    @coordinates = new Coordinates()
    @marker = undefined

    if options.lat != '' && options.lng != ''
      @coordinates.getAddressByCoordinates(@parseLatLng({ lat: options.lat, lng: options.lng }))

    @mapEvents()
    @callbacks()

  searchMapCoordinates: (address) ->
    @coordinates.getCoordinatesByAddress(address)

  createMarker: (coordinates) ->
    @destroyMarker()

    @marker = new google.maps.Marker
       position: coordinates
       map: @map
       draggable: true

    @map.setCenter(coordinates)
    @markerEvents()

  destroyMarker: ->
    @marker.setMap(null) unless @marker == undefined

  parseLatLng: (coodinates) ->
    return new google.maps.LatLng(coodinates.lat, coodinates.lng)

  callbacks: ->
    $(@coordinates).bind 'searchAddressComplete', (event, result) =>
      @createMarker(@parseLatLng({lat: result.lat, lng: result.lng}))
      $(this).trigger 'addressComplete', { result: result }

    $(@coordinates).bind 'searchCoordinatesComplete', (event, result) =>
      @createMarker(@parseLatLng({lat: result.lat, lng: result.lng}))
      $(this).trigger 'addressCoordinatesComplete', { result: result }

  markerEvents: ->
    google.maps.event.addListener @marker, 'dragend', (event) =>
      @coordinates.getAddressByCoordinates(event.latLng)
      @createMarker(event.latLng)

  mapEvents: ->
    google.maps.event.addListener @map, 'click', (event) =>
      @coordinates.getAddressByCoordinates(event.latLng)
      @createMarker(event.latLng)