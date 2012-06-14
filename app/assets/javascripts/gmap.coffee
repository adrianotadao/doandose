class window.Gmap
  lat: $('#person_address_attributes_lat')
  lng: $('#person_address_attributes_lng') 
  street: document.getElementById('address').innerHTML

  constructor: (lat, lng) ->
    @coordinate = @getCoordinate(lat, lng)
    @setMap()
    @addListener()

  updateMarkerPosition: (marker) ->
    latitude = marker.ab
    longitude = marker.cb
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

  getCoordinate: (lat, lng) ->
    directionsDisplay = new google.maps.DirectionsRenderer()
    latLng = new google.maps.LatLng(lat, lng)
    return latLng

  setMap: ->
    mapDom = document.getElementById('map')
    @map = new google.maps.Map mapDom, @options()

  options: ->
    zoom: 12
    center: @coordinate
    mapTypeId: google.maps.MapTypeId.ROADMAP

  mark: ->
    mark = new google.maps.Marker
      position: @coordinate
      map: @map
      draggable: true
