class window.Gmap
  _instance = undefined

  @create: (options) ->
    _instance ?= new google.maps.Map(document.getElementById('gmap'), {
      zoom: 16,
      mapTypeId: google.maps.MapTypeId.ROADMAP
      })
    $.extend(_instance, options)

  @centralize: (coordinates) ->
    Gmap.create().setCenter(new google.maps.LatLng(coordinates[0], coordinates[1]))