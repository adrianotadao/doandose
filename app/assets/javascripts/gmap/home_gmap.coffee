class window.HomeGmap
  constructor: (options) ->
    @navigator = new Navigator()

    if window.user.signedIn()
      Gmap.centralize(window.user.position())
      @navigator.position = window.user.position()
      Marker.loggedUserPosition({ draggable: true })
    else
      marker = Marker.nonLoggedUserPosition({ draggable: true })
      @navigator.position = [marker.getPosition().Xa, marker.getPosition().Ya]

    @initializeUserRadius()
    @navigator.find()
    @navigator.markerEvents()

  initializeUserRadius: ->
    GmapDrawCircle.create({ marker: Marker.userMarker(), radius: 1000 })
    GmapDrawCircle.centralize [Marker.userMarker().getPosition().Xa, Marker.userMarker().getPosition().Ya]