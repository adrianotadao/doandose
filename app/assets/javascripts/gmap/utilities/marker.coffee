class window.Marker
  @person: (coordinate, options) ->
    icon = {icon: new google.maps.MarkerImage('http://icons.iconarchive.com/icons/david-renelt/little-icon-people/32/Plain-People-icon.png')}
    marker = $.extend(Marker.base(coordinate), icon, options)
    Gmap.addMarker marker
    marker

  @company: (coordinate, options) ->
    icon = {icon: new google.maps.MarkerImage('http://icons.iconarchive.com/icons/icons-land/gis-gps-map/24/Hospital-icon.png')}
    marker = $.extend(Marker.base(coordinate), icon, options)
    Gmap.addMarker marker
    marker

  @nonLoggedUserPosition: (options) ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>
        icon = {icon: new google.maps.MarkerImage('http://www.sony.com.br/sonyericssonshop/products/mobilephones/overview/r-www.se-mc.com/cws/file/1.998964.1308638594!translation/image/aGPS-icon.png')}
        marker = $.extend(Marker.base([position.coords.latitude, position.coords.longitude]), icon, options)

        Gmap.addMarker marker
        Gmap.centralize [position.coords.latitude, position.coords.longitude]

        $.cookies.set 'lat', position.coords.latitude
        $.cookies.set 'lng', position.coords.longitude

        marker

  @loggedUserPosition: (options) ->
    icon = {icon: new google.maps.MarkerImage('http://www.sony.com.br/sonyericssonshop/products/mobilephones/overview/r-www.se-mc.com/cws/file/1.998964.1308638594!translation/image/aGPS-icon.png')}
    marker = $.extend(Marker.base([window.user.lat(), window.user.lng()]), icon, options)
    Gmap.addMarker marker
    Gmap.centralize [window.user.lat(), window.user.lng()]
    marker

  @default: (coordinate, options) ->
    marker = $.extend(Marker.base(coordinate), options)
    Gmap.addMarker marker
    marker

  @base: (coordinate) ->
    new google.maps.Marker
      position: new google.maps.LatLng(coordinate[0], coordinate[1])
      map: Gmap.create()