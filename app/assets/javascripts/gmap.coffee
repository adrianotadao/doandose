class window.Coordinates
  numberInput: $('.number')
  street: $('#person_address_attributes_street') 
  number: $('#person_address_attributes_number')
  city: $('#person_address_attributes_city')
  state: $('select#person_address_attributes_state')
  lat: $('#person_address_attributes_lat')
  lng: $('#person_address_attributes_lng')  

  constructor: ->
    @numberInput.focusout => @geoCoder()
    $('input.save').click => @geoCoder()

  geoCoder: ->
    geo = new google.maps.Geocoder()
    geo.geocode {
      address: @getAddress()
    }, 
    (result, status) =>
      @setCoordinates(result) if status == 'OK'

  getAddress: ->
    "#{@number.val()}, #{@street.val()}, #{@city.val().replace('Rua: ', '')}, #{@state.val()}" 

  coord: (result) ->
    coords = result[0].geometry.location
    return coords

  setCoordinates: (result) ->
    value = @coord(result)
    latitude = value.$a
    longitude = value.ab 

    @lat.val(latitude)
    @lng.val(longitude)

class window.Gmap
  lat: $('#person_address_attributes_lat')
  lng: $('#person_address_attributes_lng') 

  constructor: (lat, lng) ->
    @coordinate = @getCoordinate(lat, lng)

    @setMap() 
    @mark() 
    @addListener()

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
    zoom: 18
    center: @coordinate
    mapTypeId: google.maps.MapTypeId.ROADMAP

  mark: ->
    mark = new google.maps.Marker
      position: @coordinate
      map: @map
      draggable: true

