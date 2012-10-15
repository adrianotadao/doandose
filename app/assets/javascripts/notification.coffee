class window.Notification
  @list: ->
    for map in $('.mini_map')
      gmap = new google.maps.Map(document.getElementById($(map).attr('id')), {
        zoom: 15,
        mapTypeId: google.maps.MapTypeId.ROADMAP
        center: new google.maps.LatLng $(map).data().lat, $(map).data().lng
      })

      Marker.company [$(map).data().lat, $(map).data().lng], {map: gmap}

  @show: (options) ->
    Marker.company(options.destination)
    Gmap.centralize(options.destination)

    if window.user.signedIn()
      Marker.loggedUserPosition()
    else
      Marker.nonLoggedUserPosition()

    new Direction(options) if options.painel