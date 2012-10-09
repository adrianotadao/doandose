class window.Marker
  @create: (map, coordinate, options) ->
    marker = new google.maps.Marker
        position: new google.maps.LatLng(coordinate.lat, coordinate.lng)
        map: map
    $.extend(marker, options)