class window.Coordinates
  numberInput: $('.number')
  street: $('.street')
  number: $('.number')
  city: $('.city')
  state: $('.state')
  lat: $('.lat')
  lng: $('.lng')

  constructor: ->
    @numberInput.focusout => @getCoordinates()

  getCoordinates: ->
    new google.maps.Geocoder().geocode {
      address: @parseAddress()
    },
    (result, status) =>
      @setCoordinates(result) if status == 'OK'

  parseAddress: ->
    "#{@number.val()}, #{@street.val()}, #{@city.val().replace('Rua: ', '')}, #{@state.val()}"

  parsetCoordinates: (result) ->
    return result[0].geometry.location

  setCoordinates: (result) ->
    @lat.val(@parsetCoordinates(result).Xa)
    @lng.val(@parsetCoordinates(result).Ya)