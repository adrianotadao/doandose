class window.Gmap
  constructor: (options) ->
    @map = new google.maps.Map(document.getElementById(options.map), @options())
    @mgr = new MarkerManager(@map);

    @plotMarkers()

  plotMarkers: ->
    @coordinates = [
              [-21.2906519, -50.34905960000003],
              [-21.2864472, -50.34733670000003],
              [-21.2882566, -50.33185070000002],
              [-21.290881, -50.32840620000002],
              [-21.2925529, -50.348690199999965],
              [-21.3081091, -50.33811539999999]
            ]
    @markers = []

    for coordinate in @coordinates
      marker = new google.maps.Marker
        position: new google.maps.LatLng coordinate[0], coordinate[1]
        map: @map

      @markers.push marker

    @mgr.addMarkers(@markers)

  options: ->
    zoom: 15
    center: new google.maps.LatLng(-21.289211122989194, -50.33786645853576)
    mapTypeId: google.maps.MapTypeId.ROADMAP