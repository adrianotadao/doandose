class window.AddressableGmap
  constructor: (options) ->
    @coordinates = new Coordinates()
    @marker = undefined
    @map = new google.maps.Map(document.getElementById(options.map), @options())

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

  options: ->
    zoom: 15
    center: new google.maps.LatLng(-21.289211122989194, -50.33786645853576)
    mapTypeId: google.maps.MapTypeId.ROADMAP

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