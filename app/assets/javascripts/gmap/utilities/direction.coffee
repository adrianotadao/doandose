class window.Direction extends window.GmapBase
  constructor: (options) ->
    super(options)
    @directionsRenderer = new google.maps.DirectionsRenderer()
    @directionsRenderer.setMap(@map)

    #console.log options, @directionsRenderer