class window.Notification extends window.GmapBase
  constructor: (options) ->
    super(options)

    Marker.company(@map, options.to)
    Gmap.centralize(@map, options.to)