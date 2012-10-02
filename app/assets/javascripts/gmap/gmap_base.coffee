class window.GmapBase
  constructor: (options) ->
    @map = new google.maps.Map(document.getElementById(options.map), @options())
    @userPosition()

  userPosition: ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>
        @map.setCenter(new google.maps.LatLng(position.coords.latitude, position.coords.longitude))

  options: ->
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP