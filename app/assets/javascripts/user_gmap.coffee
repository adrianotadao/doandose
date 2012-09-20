class window.UserGmap
  lat: $('.lat')
  lng: $('.lng')

  constructor: ->
    @marker = undefined
    @infoWindow = undefined
    @map = new google.maps.Map document.getElementById('gmap'), @options()
    @coordinates = new Coordinates()
    @addMapListeners()

    $(@coordinates).bind 'searchAddressComplete', (event, result) =>
      @openMarkerInfoWindow(result.address.formatted_address)
      $(this).trigger 'addressComplete', { result: result }

  searchMapCoordinates: (address) ->
    $(@coordinates).bind 'searchCoordinatesComplete', (event, coordinates) =>
      @createMarker(@parseLatLng(coordinates))
      @lat.val(coordinates.lat)
      @lng.val(coordinates.lng)

    @coordinates.getCoordinatesByAddress(address)
    @openMarkerInfoWindow(coordinates, "Latitude: #{coordinates.lat} <br/> Longitude: #{coordinates.lng}")

  createMarker: (coordinates) ->
    @marker.setMap(null) unless @marker == undefined
    @marker = new google.maps.Marker
       position: coordinates
       map: @map
       draggable: true

    @addMarkerListeners()
    @updateMarkerPosition()
    @map.setCenter(coordinates)

  parseLatLng: (coodinates) ->
    return new google.maps.LatLng(coodinates.lat, coodinates.lng)

  options: ->
    zoom: 15
    center: new google.maps.LatLng(-21.289211122989194, -50.33786645853576)
    mapTypeId: google.maps.MapTypeId.ROADMAP

  addMarkerListeners: ->
    google.maps.event.addListener @marker, 'dragstart', =>
      @closeInfoWindow()

    google.maps.event.addListener @marker, 'drag', =>
      @updateMarkerPosition()

    google.maps.event.addListener @marker, 'dragend', (event) =>
      @coordinates.getAddressByCoordinates(event.latLng)
      @createMarker(event.latLng)

    google.maps.event.addListener @marker, 'click', (event) =>
      @openMarkerInfoWindow(event.latLng)

  addMapListeners: ->
    google.maps.event.addListener @map, 'click', (event) =>
      @coordinates.getAddressByCoordinates(event.latLng)
      @createMarker(event.latLng)

  closeInfoWindow: ->
    @infoWindow.close() unless @infoWindow == undefined

  openMarkerInfoWindow: (content) ->
    @closeInfoWindow()
    @infoWindow = new google.maps.InfoWindow
      content: content
    @infoWindow.open(@map, @marker)

  updateMarkerPosition: (coordinates=@marker.getPosition()) ->
    @lat.val(coordinates.Xa)
    @lng.val(coordinates.Ya)