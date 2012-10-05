class window.HomeGmap extends GmapBase
  constructor: (options) ->
    super(options)
    @mgr = new MarkerManager(@map)
    @markers = []

    @prepareMarkers(options.companies, 'http://icons.iconarchive.com/icons/icons-land/gis-gps-map/24/Hospital-icon.png')
    @prepareMarkers(options.people, 'http://icons.iconarchive.com/icons/david-renelt/little-icon-people/32/Plain-People-icon.png')

    @plotMarkers(@markers)

  prepareMarkers: (coordinates, iconUrl=null) ->
    for coordinate in coordinates
      marker = new google.maps.Marker
        position: new google.maps.LatLng(coordinate[0], coordinate[1])
        map: @map

      marker.icon = new google.maps.MarkerImage(iconUrl) if iconUrl
      @markers.push marker

  plotMarkers: (markers) ->
    @mgr.addMarkers(markers)
    @markers = []