class window.Marker
  @person: (coordinate, options) ->
    icon = {icon: new google.maps.MarkerImage('http://icons.iconarchive.com/icons/david-renelt/little-icon-people/32/Plain-People-icon.png')}
    marker = new google.maps.Marker $.extend(Marker.base(coordinate), icon, options)
    Marker.markerControl(marker, options)
    marker

  @company: (coordinate, options) ->
    icon = {icon: new google.maps.MarkerImage('http://icons.iconarchive.com/icons/icons-land/gis-gps-map/24/Hospital-icon.png')}
    marker = new google.maps.Marker $.extend(Marker.base(coordinate), icon, options)
    Marker.markerControl(marker, options)
    marker

  @nonLoggedUserPosition: (options) ->
    icon = {icon: new google.maps.MarkerImage('http://www.sony.com.br/sonyericssonshop/products/mobilephones/overview/r-www.se-mc.com/cws/file/1.998964.1308638594!translation/image/aGPS-icon.png')}
    marker = new google.maps.Marker $.extend(Marker.base([0,0]), icon, options)

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>
        marker.setPosition(new google.maps.LatLng(position.coords.latitude, position.coords.longitude))
        Marker.markerControl(marker, options)
        Gmap.centralize [position.coords.latitude, position.coords.longitude]

        $.cookies.set 'lat', position.coords.latitude
        $.cookies.set 'lng', position.coords.longitude

        $(marker).trigger 'userPositionFound'

    marker

  @loggedUserPosition: (options) ->
    icon = {icon: new google.maps.MarkerImage('http://www.sony.com.br/sonyericssonshop/products/mobilephones/overview/r-www.se-mc.com/cws/file/1.998964.1308638594!translation/image/aGPS-icon.png')}
    marker = new google.maps.Marker $.extend(Marker.base([window.user.lat(), window.user.lng()]), icon, options)
    Marker.markerControl(marker, options)
    Gmap.centralize [window.user.lat(), window.user.lng()]
    marker

  @default: (coordinate, options) ->
    marker = new google.maps.Marker $.extend(Marker.base(coordinate), options)
    Marker.markerControl(marker, options)
    marker

  @markerControl: (marker, options) ->
    if options && options.map
      marker.setMap options.map
    else
      marker.setMap Gmap.create()

  @base: (coordinate) ->
    position: new google.maps.LatLng(coordinate[0], coordinate[1])