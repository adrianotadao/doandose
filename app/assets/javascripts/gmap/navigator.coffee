class window.Navigator
  constructor: ->
    google.maps.event.addListener Gmap.create(), 'dragend', ->
      Gmap.create().getCenter()