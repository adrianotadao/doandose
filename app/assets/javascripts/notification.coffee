class window.Notification
  constructor: (options) ->
    Marker.company(options.destination)
    Gmap.centralize(options.destination)

    if window.user.signedIn()
      Marker.loggedUserPosition()

      new Direction(options)