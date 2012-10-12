class window.Marker
  @person: (coordinate, options) ->
    icon = {icon: new google.maps.MarkerImage('http://icons.iconarchive.com/icons/david-renelt/little-icon-people/32/Plain-People-icon.png')}
    $.extend(Marker.base(coordinate), icon, options)

  @company: (coordinate, options) ->
    icon = {icon: new google.maps.MarkerImage('http://icons.iconarchive.com/icons/icons-land/gis-gps-map/24/Hospital-icon.png')}
    $.extend(Marker.base(coordinate), icon, options)

  @nonLoggedUserPosition: (options) ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>
        icon = {icon: new google.maps.MarkerImage('http://www.sony.com.br/sonyericssonshop/products/mobilephones/overview/r-www.se-mc.com/cws/file/1.998964.1308638594!translation/image/aGPS-icon.png')}
        $.extend(Marker.base([position.coords.latitude, position.coords.longitude]), icon, options)

        Gmap.centralize([position.coords.latitude, position.coords.longitude])

        $.cookies.set 'lat', position.coords.latitude
        $.cookies.set 'lng', position.coords.longitude

  @loggedUserPosition: (options) ->
    icon = {icon: new google.maps.MarkerImage('http://www.sony.com.br/sonyericssonshop/products/mobilephones/overview/r-www.se-mc.com/cws/file/1.998964.1308638594!translation/image/aGPS-icon.png')}
    $.extend(Marker.base([window.user.lat(), window.user.lng()]), icon, options)

    Gmap.centralize([window.user.lat(), window.user.lng()])

  @default: (coordinate, options) ->
    $.extend(Marker.base(coordinate), options)

  @base: (coordinate) ->
    new google.maps.Marker
      position: new google.maps.LatLng(coordinate[0], coordinate[1])
      map: Gmap.create()