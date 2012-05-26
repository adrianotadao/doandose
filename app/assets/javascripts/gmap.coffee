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
  constructor: (lat, lng) ->
    console.log lat
    console.log lng
    coordinate = @getCoordinate(lat, lng)

    @setMap(coordinate) 
    @mark(coordinate)    
  
  getCoordinate: (lat, lng) ->
    directionsDisplay = new google.maps.DirectionsRenderer()
    latLng = new google.maps.LatLng(lat, lng)
    return latLng

  setMap: (coordinate) ->
    mapDom = document.getElementById('map')
    @map = new google.maps.Map(mapDom, @options(coordinate))

  options: (coordinate) ->
    zoom: 18
    center: coordinate
    mapTypeId: google.maps.MapTypeId.ROADMAP

  mark: (coordinate) ->
    mark = new google.maps.Marker
      position: coordinate
      map: @map
      draggable: true
