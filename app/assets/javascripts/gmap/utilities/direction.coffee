class window.Direction
  constructor: (options) ->
    @directionsRenderer = new google.maps.DirectionsRenderer()
    @directionsService = new google.maps.DirectionsService()

    @directionsRenderer.setMap Gmap.create()
    @directionsRenderer.setPanel document.getElementById(options.panel)

    @calculeRoute(options)

  calculeRoute: (options) ->
    request =
      origin: "#{window.user.userPotision()[0]}, #{window.user.userPotision()[1]}",
      destination: "#{options.destination[0]}, #{options.destination[1]}",
      travelMode: google.maps.DirectionsTravelMode.DRIVING

    @directionsService.route request, (response, status) =>
      if (status == google.maps.DirectionsStatus.OK)
        @directionsRenderer.setDirections(response)