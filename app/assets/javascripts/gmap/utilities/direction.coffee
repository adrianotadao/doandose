class window.Direction extends
  constructor: (options) ->
    @directionsRenderer = new google.maps.DirectionsRenderer()
    @directionsRenderer.setMap(Gmap.create())

    #console.log options, @directionsRenderer