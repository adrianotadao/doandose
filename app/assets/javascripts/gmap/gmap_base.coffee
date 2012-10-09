class window.GmapBase
  constructor: (options) ->
    @map = Gmap.createMap(options.map, 13)
    @coordinate = null

    if options.showPosition
      @centerMap(options.showPosition.lat, options.showPosition.lng)
    else if window.user.signedIn()
      @centerMap(window.user.lat(), window.user.lng())
    else
      @userPosition()

  userPosition: ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>
        @centerMap(position.coords.latitude, position.coords.longitude)

  centerMap: (lat, lng) ->
    @coordinate = new google.maps.LatLng(lat, lng)
    @map.setCenter(@coordinate)
    @currentMarker()

  currentMarker: ->
    new google.maps.Marker
       position: @coordinate
       map: @map
       icon: new google.maps.MarkerImage "http://www.sony.com.br/sonyericssonshop/products/mobilephones/overview/r-www.se-mc.com/cws/file/1.998964.1308638594!translation/image/aGPS-icon.png"