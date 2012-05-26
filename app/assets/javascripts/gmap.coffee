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
            geo = new google.maps.Geocoder()
            geo.geocode {
                address: @getAddress()
            }, 
            (result, status) =>
                if status == 'OK'

                  coords = result[0].geometry.location
                  latitude = coords.$a
                  longitude = coords.ab                                 
                  
                  @lat.val(latitude)
                  @lng.val(longitude)

                  options = 
                      zoom: 18
                      center: coords
                      mapTypeId: google.maps.MapTypeId.ROADMAP

                  mapDom = document.getElementById('map')
                  map = new google.maps.Map(mapDom, options)

                  mark = new google.maps.Marker
                      position: coords
                      map: map
                      draggable: true

    getAddress: ->
        "#{@number.val()}, #{@street.val()}, #{@city.val().replace('Rua: ', '')}, #{@state.val()}" 
