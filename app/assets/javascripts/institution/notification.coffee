class window.Notification
  constructor: ->
    @request = undefined
    @blood = $('.blood')
    @distance = $('.distance')
    @slider = $("#distances .range")

    @prepareBloods()
    Marker.loggedUserPosition()
    @initializeUserRadius()
    @distanceFilters()
    @hasValues()

  hasValues: ->
    if @blood.val() != ''
      @find()

    if @distance.val() == ''
      @distance.val(1)

  initializeUserRadius: ->
    GmapDrawCircle.create({ marker: Marker.userMarker(), radius: 1000 })
    GmapDrawCircle.centralize [Marker.userMarker().getPosition().Ya, Marker.userMarker().getPosition().Za]

  distanceFilters: ->
    @slider.slider {
      range: "max",
      min: 1,
      max: 200,
      slide: ( event, ui ) =>
        @distance.val(ui.value)
        @updateDistance()
        GmapDrawCircle.changeRadius parseInt(@distance.val()) * 1000
        clearInterval(@interval)
        @interval = window.setTimeout (=>
          @refreshMap()
        ), 1000
    }

    @slider.slider('value', @distance.val())
    @updateDistance()

  updateDistance: ->
    $('span.range_value').text("#{@distance.val()} KM")

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
      @blood.val($(e.currentTarget).text())
      @refreshMap()

  find: ->
    @query.abort() if @query != undefined
    return if @blood.val() == '' || @distance.val() == ''
    @request = $.ajax
      url: '/find_elements_to_notification'
      type: 'POST'
      data: $.extend { position: {lat: window.user.lat(), lng: window.user.lng()}}, @filters()
      success: (data) => @onSuccess data
      error: (xhr, error) -> console.log xhr, error

  filters: ->
    { blood: @blood.val(), distance: @distance.val() }

  onSuccess: (options) ->
    html = "<table class='result'>"
    html += "<thead>
              <tr>
                <th class='distance'>Distancia</th>
                <th class='name'>Nome</th>
                <th class='name'>Sangue</th>
                <th class='address'>Endereço</th>
              </tr>
            </thead>
            <tbody>"

    options.people.map (person) =>
      marker = Marker.person([person.lat, person.lng])
      PersonList.add {id: person.id, marker: marker, distance: "#{person.distance[0]}#{person.distance[1]}"}

      html += "<tr id = '#{person.id}'>
                  <td>#{person.distance[0]}#{person.distance[1]}</td>
                  <td>#{person.blood}</td>
                  <td>#{person.name}</td>
                  <td>#{person.address}</td>
                </tr>"

    html += '</tbody></table>'
    $('#result').html html

    @markerEvents()
    @counter(options.counters)

  counter: (counters) ->
    $('#counter').empty()
    counters.map (counter) =>
      $('#counter').append "<p>#{counter[0]} = #{counter[1]}</p>"

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