class window.Gmap
  lat: $('#person_address_attributes_lat')
  lng: $('#person_address_attributes_lng') 

  constructor: (lat, lng) ->
    @coordinate = @getCoordinate(lat, lng)

    @setMap() 
    @mark() 
    @addListener()
    @bubble()

   
  bubble: ->            
    contentString = "Testando o bubble"
    infowindow = new google.maps.InfoWindow(content: contentString)

    google.maps.event.addListener @mark(), "click", =>
      infowindow.open @map, @mark()

    infowindow.open @map, @mark()

  updateMarkerPosition: (marker) ->
    latitude = marker.$a
    longitude = marker.ab

    @lat.val(latitude)
    @lng.val(longitude)

  addListener: ->
    currentMark = @currentMark()
    google.maps.event.addListener currentMark, "drag", =>
      @updateMarkerPosition(currentMark.getPosition())

  currentMark: ->
    marker = new google.maps.Marker
      position: @coordinate
      map: @map
      draggable: true
  
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
