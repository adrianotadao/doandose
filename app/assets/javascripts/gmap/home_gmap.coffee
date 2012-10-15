class window.HomeGmap
  constructor: (options) ->
    @navigator = new Navigator()

    if window.user.signedIn()
      marker = Marker.loggedUserPosition()
    else
      marker = Marker.nonLoggedUserPosition()

    @navigator.find([marker.getPosition().Xa, marker.getPosition().Ya])