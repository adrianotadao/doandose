class window.UserGmap
  constructor: ->
    @marker = undefined
    @map = new google.maps.Map document.getElementById('gmap'), @options()
    #@addListener()

  searchMapCoordinates: (address) ->
    @coordinates = new Coordinates()
    @coordinates.getCoordinates(address)
    $(@coordinates).bind 'searchCoordinatesComplete', (event, coordinates) =>
      @createMarker(coordinates)

  createMarker: (coordinates) ->
    @marker.setMap(null) unless @marker == undefined
    @marker = new google.maps.Marker
       position: @parseLatLng(coordinates.lat, coordinates.lng)
       map: @map
       draggable: true

  parseLatLng: (lat, lng) ->
    directionsDisplay = new google.maps.DirectionsRenderer()
    latLng = new google.maps.LatLng(lat, lng)
    return latLng

  options: ->
    zoom: 15
    center: new google.maps.LatLng(-21.2783943, -50.32854309999999)
    mapTypeId: google.maps.MapTypeId.ROADMAP

  updateMarkerPosition: (marker) ->
    latitude = marker.$a
    longitude = marker.ab
    @lat.val(latitude)
    @lng.val(longitude)

  addListener: ->
    currentMark = @mark()
    contentString = @street
    infowindow = new google.maps.InfoWindow({content: contentString})

    google.maps.event.addListener currentMark, "drag", =>
      @updateMarkerPosition(currentMark.getPosition())
      infowindow.open @map, currentMark
    google.maps.event.addListener currentMark, "click", =>
      infowindow.open @map, currentMark

