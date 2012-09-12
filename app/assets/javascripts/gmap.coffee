class window.Gmap
  lat: undefined
  lng: undefined
  #street: document.getElementById('address').innerHTML

  constructor: (lat, lng) ->
    #@coordinate = @getCoordinate(lat, lng)
    @lat = lat
    @lng = lng

    @parseLatLng()
    @setMap()
    @addListener()

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

  parseLatLng: ->
    directionsDisplay = new google.maps.DirectionsRenderer()
    latLng = new google.maps.LatLng(@lat, @lng)
    console.log latLng
    return latLng

  setMap: ->
    @map = new google.maps.Map $('#gmap'), @options()

  options: ->
    zoom: 12
    center: @coordinate
    mapTypeId: google.maps.MapTypeId.ROADMAP

  mark: ->
    mark = new google.maps.Marker
      position: @coordinate
      map: @map
      draggable: true
