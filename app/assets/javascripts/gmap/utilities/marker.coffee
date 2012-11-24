class window.Marker
  _userMarker = undefined

  @person: (coordinate, options) ->
    marker = new google.maps.Marker $.extend(Marker.base(coordinate), options)
    Marker.markerControl(marker, options)
    marker

  @company: (coordinate, options) ->
    marker = new google.maps.Marker $.extend(Marker.base(coordinate), options)
    Marker.markerControl(marker, options)
    marker

  @nonLoggedUserPosition: (options) ->
    marker = new google.maps.Marker $.extend(Marker.base([0,0]), options)

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>

        marker.setPosition(new google.maps.LatLng(position.coords.latitude, position.coords.longitude))
        Marker.markerControl(marker, options)
        Gmap.centralize [position.coords.latitude, position.coords.longitude]

        $.cookies.set 'lat', position.coords.latitude
        $.cookies.set 'lng', position.coords.longitude


        $(marker).trigger 'userPositionFound'

    _userMarker = marker
    marker

  @loggedUserPosition: (options) ->
    marker = new google.maps.Marker $.extend(Marker.base([window.user.lat(), window.user.lng()]), options)
    Marker.markerControl(marker, options)
    Gmap.centralize [window.user.lat(), window.user.lng()]
    _userMarker = marker
    marker

  @default: (coordinate, options) ->
    marker = new google.maps.Marker $.extend(Marker.base(coordinate), options)
    Marker.markerControl(marker, options)
    _userMarker = marker
    marker

  @markerControl: (marker, options) ->
    if options && options.map
      marker.setMap options.map
    else
      marker.setMap Gmap.create()

  @base: (coordinate) ->
    position: new google.maps.LatLng(coordinate[0], coordinate[1])

  @userMarker: ->
    _userMarker

  @centralizeUserMarker: (coordinate) ->
    return if _userMarker == undefined
    _userMarker.setPosition(new google.maps.LatLng(coordinate[0], coordinate[1]))