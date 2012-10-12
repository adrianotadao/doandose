class window.Direction
  constructor: (options) ->
    @directionsRenderer = new google.maps.DirectionsRenderer()
    @directionsService = new google.maps.DirectionsService()

    @directionsRenderer.setMap Gmap.create()
    @directionsRenderer.setPanel document.getElementById(options.panel)

    @calculateRoute(options)

    $('#directionPanelControl a').click (e) => @directionPanelClicked(options, e)

  directionPanelClicked: (options, e=null) ->
    @calculateRoute(options, $(e.currentTarget).data().travelmode)

  calculateRoute: (options, travelMode='DRIVING') ->
    request =
      origin: "#{window.user.userPotision()[0]}, #{window.user.userPotision()[1]}",
      destination: "#{options.destination[0]}, #{options.destination[1]}",
      travelMode: google.maps.DirectionsTravelMode[travelMode]

    @directionsService.route request, (response, status) =>
      if (status == google.maps.DirectionsStatus.OK)
        @directionsRenderer.setDirections(response)