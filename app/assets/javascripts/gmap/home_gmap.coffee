class window.HomeGmap extends GmapBase
  constructor: (options) ->
    super(options)
    @mgr = new MarkerManager(@map)
    @markers = []

    @prepareMarkers(options.companies, {icon: new google.maps.MarkerImage('http://icons.iconarchive.com/icons/icons-land/gis-gps-map/24/Hospital-icon.png')})
    @prepareMarkers(options.people, {icon: new google.maps.MarkerImage('http://icons.iconarchive.com/icons/david-renelt/little-icon-people/32/Plain-People-icon.png')})

    @plotMarkers(@markers)

  prepareMarkers: (coordinates, icon) ->
    for coordinate in coordinates
      @markers.push Marker.create(@map, coordinate, icon)

  plotMarkers: (markers) ->
    @mgr.addMarkers(markers)
    @markers = []