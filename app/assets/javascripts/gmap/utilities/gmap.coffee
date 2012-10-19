class window.Gmap
  _instance = undefined
  _markers = []

  @create: (options) ->
    _instance ?= new google.maps.Map(document.getElementById('gmap'), {
      zoom: 15,
      mapTypeId: google.maps.MapTypeId.ROADMAP
      })
    $.extend(_instance, options)

  @centralize: (coordinates) ->
    _instance.setCenter(new google.maps.LatLng(coordinates[0], coordinates[1]))

  @getMap: ->
    _instance