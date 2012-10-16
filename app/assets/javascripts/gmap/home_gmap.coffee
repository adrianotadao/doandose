class window.HomeGmap
  constructor: (options) ->
    @navigator = new Navigator()

    if window.user.signedIn()
      @navigator.find(window.user.position())
      Gmap.centralize(window.user.position())
    else
      marker = Marker.nonLoggedUserPosition()
      @navigator.find([marker.getPosition().Xa, marker.getPosition().Ya])