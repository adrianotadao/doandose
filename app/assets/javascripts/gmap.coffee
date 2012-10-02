class window.Gmap
  constructor: (options) ->
    @map = new google.maps.Map(document.getElementById(options.map), @options())
    @mgr = new MarkerManager(@map);

    @userPosition()
    @plotMarkers(options.coordinates)

  userPosition: ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>
        @map.setCenter(new google.maps.LatLng(position.coords.latitude, position.coords.longitude))

  plotMarkers: (coordinates) ->
    @markers = []

    for coordinate in coordinates
      marker = new google.maps.Marker
        position: new google.maps.LatLng coordinate[0], coordinate[1]
        map: @map
      @markers.push marker

    @mgr.addMarkers(@markers)

  options: ->
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP