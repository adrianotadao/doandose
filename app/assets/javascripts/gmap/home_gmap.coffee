class window.HomeGmap extends GmapBase
  constructor: (options) ->
    super(options)

    @plotMarkers(options)

  plotMarkers: (options) ->
    @markers = []

    #companies
    for coordinate in options.companies
      @markers.push Marker.company(@map, coordinate)

    #peopler
    for coordinate in options.people
      @markers.push Marker.person(@map, coordinate)

    new MarkerManager(@map).addMarkers(@markers)