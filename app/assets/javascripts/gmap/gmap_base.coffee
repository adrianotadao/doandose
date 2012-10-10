class window.GmapBase
  coordinate: undefined
  constructor: (options) ->
    @map = Gmap.createMap(options.map, 13)

    if options.showUserPosition
      @userPosition()
      Marker.userPosition(@map, @coordinate)
    else
      if window.user.signedIn()
        @coordinate = [window.user.lat(), window.user.lng()]
        Marker.userPosition(@map, @coordinate)
        @centerMap()
      else
        @userPosition()

  userPosition: ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>
        @coordinate = [position.coords.latitude, position.coords.longitude]
        @centerMap()

  centerMap: ->
    @map.setCenter(new google.maps.LatLng(@coordinate[0], @coordinate[1]))