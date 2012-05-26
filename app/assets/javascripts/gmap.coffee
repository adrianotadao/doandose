class window.Gmap

  numberInput: $('.number')
  street: $('#person_address_attributes_street') 
  number: $('#person_address_attributes_number')
  city: $('#person_address_attributes_city')
  state: $('select#person_address_attributes_state')
  lat: $('#person_address_attributes_lat')
  lng: $('#person_address_attributes_lng')    

  constructor: ->
    @numberInput.focusout =>
      @geoCoder()

  geoCoder: ->
    geo = new google.maps.Geocoder()
    geo.geocode {
      address: @getAddress()
    }, 
    (result, status) =>
        @setMap(status)

  setMap: (status) ->
    if status == 'OK'
      mapDom = document.getElementById('map')
      map = new google.maps.Map(mapDom, @options())

  options: ->
    zoom: 18
    center: @coodenation()
    mapTypeId: google.maps.MapTypeId.ROADMAP

  coordenation: (result) ->
    coords = result[0].geometry.location
    @latitude = coords.$a
    @longitude = coords.ab 

  setCoordenation: ->
    @lat.val(@coordenation.latitude)
    @lng.val(@coordenation.longitude)
  
  mark: ->
    mark = new google.maps.Marker
      position: @coordenation.coords
      map: map
      draggable: true

  getAddress: ->
    "#{@number.val()}, #{@street.val()}, #{@city.val().replace('Rua: ', '')}, #{@state.val()}" 
