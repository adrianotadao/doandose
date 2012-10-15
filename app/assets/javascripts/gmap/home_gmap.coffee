class window.HomeGmap
  constructor: (options) ->
    @navigator = new Navigator()

    if window.user.signedIn()
      Marker.loggedUserPosition()
    else
      Marker.nonLoggedUserPosition()

    @plotMarkers(options)

  plotMarkers: (options) ->
    #companies
    for coordinate in options.companies
      Marker.company(coordinate)

    #peopler
    for coordinate in options.people
      Marker.person(coordinate)

    new MarkerManager(Gmap.create()).addMarkers(Gmap.markers())