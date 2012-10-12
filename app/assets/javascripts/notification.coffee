class window.Notification
  constructor: (options) ->
    Marker.company(options.to)
    Gmap.centralize(options.to)

    if window.user.signedIn()
      Marker.loggedUserPosition()