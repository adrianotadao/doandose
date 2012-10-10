class window.GmapBase
  coordinate: undefined
  constructor: (options) ->
    @map = Gmap.createMap(options.map, 13)

    unless options.manualPosition
      if options.showUserPosition
        @userPosition(true)
      else
        if window.user.signedIn()
          @coordinate = [window.user.lat(), window.user.lng()]
          Marker.userPosition(@map, @coordinate)
          @centerMap()
        else
          @userPosition(false)

  userPosition: (plotUser) ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>
        @coordinate = [position.coords.latitude, position.coords.longitude]
        @centerMap()
        Marker.userPosition(@map, @coordinate) if plotUser

  centerMap: ->
    @map.setCenter(new google.maps.LatLng(@coordinate[0], @coordinate[1]))