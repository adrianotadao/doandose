class window.GmapDrawCircle
  _instance = undefined

  @create: (options) ->
    circleOptions = {
        strokeColor: "#690303",
        strokeOpacity: 0.6,
        strokeWeight: 0.5,
        fillColor: "#ff0808",
        fillOpacity: 0.05,
        map: Gmap.create(),
        radius: options.radius
    }

    _instance ?= new google.maps.Circle circleOptions
    _instance.bindTo('center', options.marker, 'position')
    _instance

  @centralize: (coordinates) ->
    _instance.setCenter(new google.maps.LatLng(coordinates[0], coordinates[1]))

  @changeRadius: (radius) ->
    _instance.setRadius radius

  @getCircle: ->
    _instance