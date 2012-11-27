class window.HomeGmap
  constructor: (options) ->
    @navigator = new Navigator()

    if window.user.signedIn()
      Gmap.centralize(window.user.position())
      @navigator.position = window.user.position()
      Marker.loggedUserPosition({ draggable: true })
      @initializeNavigator()
    else
      marker = Marker.nonLoggedUserPosition({ draggable: true })
      $(marker).bind 'userPositionFound', =>
        @navigator.position = [marker.getPosition().$a, marker.getPosition().ab]
        @initializeNavigator()

  initializeNavigator: ->
    @initializeUserRadius()
    @navigator.find()
    @navigator.markerEvents()

  initializeUserRadius: ->
    GmapDrawCircle.create({ marker: Marker.userMarker(), radius: 1000 })
    GmapDrawCircle.centralize [Marker.userMarker().getPosition().$a, Marker.userMarker().getPosition().ab]