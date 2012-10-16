class window.HomeGmap
  constructor: (options) ->
    @navigator = new Navigator()

    if window.user.signedIn()
      @navigator.position = window.user.position()
      Gmap.centralize(window.user.position())
    else
      marker = Marker.nonLoggedUserPosition()
      @navigator.position = [marker.getPosition().Xa, marker.getPosition().Ya]

    @navigator.find()