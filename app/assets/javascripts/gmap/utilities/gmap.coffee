class window.Gmap
  @createMap: (el, zoom) ->
    new google.maps.Map(document.getElementById(el), {
      zoom: zoom,
      mapTypeId: google.maps.MapTypeId.ROADMAP
      })

  @centralize: (map, coordinates) ->
    map.setCenter(new google.maps.LatLng(coordinates.lat, coordinates.lng))