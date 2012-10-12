class window.HomeGmap
  constructor: (options) ->
    if window.user.signedIn()
      Marker.loggedUserPosition()
    else
      Marker.nonLoggedUserPosition()

    @plotMarkers(options)

  plotMarkers: (options) ->
    @markers = []

    #companies
    for coordinate in options.companies
      @markers.push Marker.company(coordinate)

    #peopler
    for coordinate in options.people
      @markers.push Marker.person(coordinate)

    new MarkerManager(Gmap.create()).addMarkers(@markers)