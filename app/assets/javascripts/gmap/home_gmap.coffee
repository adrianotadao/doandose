class window.HomeGmap
  constructor: (options) ->
    @navigator = new Navigator()

    if window.user.signedIn()
      Gmap.centralize(window.user.position())
      @navigator.position = window.user.position()
      Marker.loggedUserPosition()
    else
      marker = Marker.nonLoggedUserPosition()
      @navigator.position = [marker.getPosition().Xa, marker.getPosition().Ya]

    @initializeUserRadius()
    @navigator.find()

  initializeUserRadius: ->
    GmapDrawCircle.create({ marker: Marker.userMarker(), radius: 1000 })
    GmapDrawCircle.centralize [Marker.userMarker().getPosition().Xa, Marker.userMarker().getPosition().Ya]