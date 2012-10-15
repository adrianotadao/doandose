class window.Navigator
  constructor: ->
    @query = undefined

    google.maps.event.addListener Gmap.create(), 'dragend', =>
      @find [Gmap.create().getCenter().Xa, Gmap.create().getCenter().Ya]

  find: (positions) ->
    @query.abort() if @query != undefined

    @query = $.ajax
      url: 'elements_by_user_position'
      type: 'POST'
      data: {positions: {lat: positions[0], lng: positions[1]}}
      success: (data) => @onSuccess data
      error: (xhr, error)  -> console.log xhr, error

  onSuccess: (options) ->
    #companies
    for coordinate in options.companies
      Marker.company(coordinate)

    #peopler
    for coordinate in options.people
      Marker.person(coordinate)