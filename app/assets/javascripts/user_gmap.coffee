class window.UserGmap
  lat: $('.lat')
  lng: $('.lng')

  constructor: ->
    @marker = undefined
    @map = new google.maps.Map document.getElementById('gmap'), @options()
    @addMapListeners()

  searchMapCoordinates: (address) ->
    @coordinates = new Coordinates()
    @coordinates.getCoordinates(address)
    $(@coordinates).bind 'searchCoordinatesComplete', (event, coordinates) =>
      @createMarker(@parseLatLng(coordinates))
      @lat.val(coordinates.lat)
      @lng.val(coordinates.lng)

  createMarker: (coordinates) ->
    @marker.setMap(null) unless @marker == undefined
    @marker = new google.maps.Marker
       position: coordinates
       map: @map
       draggable: true

    @addMarkerListeners()
    @updateMarkerPosition()

  parseLatLng: (coodinates) ->
    return new google.maps.LatLng(coodinates.lat, coodinates.lng)

  options: ->
    zoom: 15
    center: new google.maps.LatLng(-21.289211122989194, -50.33786645853576)
    mapTypeId: google.maps.MapTypeId.ROADMAP

  addMarkerListeners: ->
    google.maps.event.addListener @marker, 'drag', =>
      @updateMarkerPosition()

    google.maps.event.addListener @marker, 'click', (event) =>
      @openMarkerInfoWindow(event.latLng)

  addMapListeners: ->
    google.maps.event.addListener @map, 'click', (event) =>
      @createMarker(event.latLng)

  openMarkerInfoWindow: (coordinates) ->
    infoWindow = new google.maps.InfoWindow
      content: "Latitude: #{coordinates.Xa} <br/> Longitude: #{coordinates.Ya}"
    infoWindow.open(@map, @marker)

  updateMarkerPosition: (coordinates=@marker.getPosition()) ->
    @lat.val(coordinates.Xa)
    @lng.val(coordinates.Ya)