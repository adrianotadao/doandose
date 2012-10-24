class window.UserDirection
  @direction: (options) ->
    Marker.company(options.destination)
    Gmap.centralize(options.destination)

    if window.user.signedIn()
      Marker.loggedUserPosition()
    else
      Marker.nonLoggedUserPosition()

    new Direction(options) if options.painel