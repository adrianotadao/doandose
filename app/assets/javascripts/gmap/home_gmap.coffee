class window.HomeGmap extends GmapBase
  constructor: (options) ->
    super(options)
    @mgr = new MarkerManager(@map)
    @plotMarkers(options.coordinates)

  plotMarkers: (coordinates) ->
    @markers = []

    for coordinate in coordinates
      marker = new google.maps.Marker
        position: new google.maps.LatLng coordinate[0], coordinate[1]
        map: @map
        icon: new google.maps.MarkerImage 'http://www.library.arizona.edu/news/img/red_circle.png'
      @markers.push marker

    @mgr.addMarkers(@markers)