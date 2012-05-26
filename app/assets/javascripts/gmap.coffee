class window.Gmap
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
      @setMap(status, result)
      @mark(result)
      @setCoordenation(result)

  setMap: (status, result) ->
    if status == 'OK'
      mapDom = document.getElementById('map')
      @map = new google.maps.Map(mapDom, @options(result))

  options: (result) ->
    zoom: 18
    center: @coordenation(result)
    mapTypeId: google.maps.MapTypeId.ROADMAP

  coordenation: (result) ->
    coords = result[0].geometry.location
    return coords

  setCoordenation: (result) ->
    value = @coordenation(result)
    latitude = value.$a
    longitude = value.ab 
    @lat.val(latitude)
    @lng.val(longitude)
  
  mark: (result) ->
    mark = new google.maps.Marker
      position: @coordenation(result)
      map: @map
      draggable: true

  getAddress: ->
    "#{@number.val()}, #{@street.val()}, #{@city.val().replace('Rua: ', '')}, #{@state.val()}" 
