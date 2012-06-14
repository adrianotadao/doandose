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
    latitude = value.ab
    longitude = value.cb 
    @lat.val(latitude)
    @lng.val(longitude)
