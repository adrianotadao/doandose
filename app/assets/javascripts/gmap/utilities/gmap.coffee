class window.Gmap
  _instance = undefined
  _markers = []

  @create: (options) ->
    _instance ?= new google.maps.Map(document.getElementById('gmap'), {
      zoom: 16,
      mapTypeId: google.maps.MapTypeId.ROADMAP
      })
    $.extend(_instance, options)

  @addMarker: (marker) ->
    _markers.push marker

  @markers: ->
    _markers

  @removeAllMarkers: ->
    for marker in _markers
      marker.setMap(null)
    _markers = []

  @centralize: (coordinates) ->
    Gmap.create().setCenter(new google.maps.LatLng(coordinates[0], coordinates[1]))