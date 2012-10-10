class window.Marker
  @person: (map, coordinate, options) ->
    icon = {icon: new google.maps.MarkerImage('http://icons.iconarchive.com/icons/david-renelt/little-icon-people/32/Plain-People-icon.png')}
    $.extend(Marker.base(map, coordinate), icon, options)

  @company: (map, coordinate, options) ->
    icon = {icon: new google.maps.MarkerImage('http://icons.iconarchive.com/icons/icons-land/gis-gps-map/24/Hospital-icon.png')}
    $.extend(Marker.base(map, coordinate), icon, options)

  @userPosition: (map, coordinate, options) ->
    icon = {icon: new google.maps.MarkerImage('http://www.sony.com.br/sonyericssonshop/products/mobilephones/overview/r-www.se-mc.com/cws/file/1.998964.1308638594!translation/image/aGPS-icon.png')}
    $.extend(Marker.base(map, coordinate), icon, options)

  @default: (map, coordinate, options) ->
    $.extend(Marker.base(map, coordinate), options)

  @base: (map, coordinate) ->
    new google.maps.Marker
      position: new google.maps.LatLng(coordinate[0], coordinate[1])
      map: map