class window.Notification
  constructor: ->
    @request = undefined
    @distance = 1
    @buttonFilter = $('#buttonFilter')

    @prepareBloods()

    @buttonFilter.click => @find()

    Marker.loggedUserPosition()
    @initializeUserRadius()
    @distanceFilters()

  initializeUserRadius: ->
    GmapDrawCircle.create({ marker: Marker.userMarker(), radius: 1000 })
    GmapDrawCircle.centralize [Marker.userMarker().getPosition().Xa, Marker.userMarker().getPosition().Ya]

  distanceFilters: ->
    $("#distances .range").slider {
      range: "max",
      min: 1,
      max: 100,
      slide: ( event, ui ) =>
        @distance = ui.value
        $('span.range_value').text("#{@distance} KM")
        GmapDrawCircle.changeRadius @distance * 1000
        clearInterval(@interval)
        @interval = window.setTimeout (=>
          @refreshMap()
        ), 1000
    }

  refreshMap: ->
    @clearMap()
    @find()

  clearMap: ->
    PersonList.list().map (person) ->
      person.marker.setMap(null)

    PersonList.clear()

  prepareBloods: ->
    @bloods = $('#bloods span')
    @bloods.click (e) =>
      @bloods.removeClass 'selected'
      $(e.currentTarget).addClass 'selected'
      @refreshMap()

  find: ->
    @query.abort() if @query != undefined
    @request = $.ajax
      url: '/find_elements_to_notification'
      type: 'POST'
      data: $.extend { position: {lat: window.user.lat(), lng: window.user.lng()}}, @filters()
      success: (data) => @onSuccess data
      error: (xhr, error) -> console.log xhr, error

  filters: ->
    { blood: $('#bloods span.selected').text(), distance: @distance }

  onSuccess: (options) ->
    html = "<table class='result'>"
    html += "<thead>
              <tr>
                <th class='distance'>Distancia</th>
                <th class='name'>Nome</th>
                <th class='address'>Endereço</th>
              </tr>
            </thead>
            <tbody>"

    options.people.map (person) =>
      marker = Marker.person([person.lat, person.lng])
      PersonList.add {id: person.id, marker: marker, distance: "#{person.distance[0]}#{person.distance[1]}"}

      html += "<tr id = '#{person.id}'>
                  <td>#{person.distance[0]}#{person.distance[1]}</td>
                  <td>#{person.name}</td>
                  <td>#{person.address}</td>
                </tr>"

    html += '</tbody></table>'
    $('#result').html html

    @markerEvents()

  markerEvents: ->
    infowindow = new google.maps.InfoWindow

    $('#result table tbody tr').mouseover (e) =>
      infowindow.close()
      for person in PersonList.list()
        if person.id == $(e.currentTarget).attr('id')
          marker = person.marker
          infowindow.setContent person.distance
          break
      infowindow.open(Gmap.create(), marker)