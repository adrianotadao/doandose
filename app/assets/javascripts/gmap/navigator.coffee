class window.Navigator
  constructor: ->
    @query = undefined
    @interval = undefined
    @position = []
    @distance = 1

    @mapEvents()
    @prepareAutocomplete()
    @bloodFilters()
    @distanceFilters()
    @prepareType()

  filters: ->
    bloodTypes = []
    for type in $('#filter_content #bloods span.selected')
      bloodTypes.push $(type).text()

    if $('span.institutional').hasClass 'selected'
      type = 'company'
    else
      type = 'person'

    { blood_types: bloodTypes, distance: @distance, type: type }

  bloodFilters: ->
    $('#filter_content #bloods span').click (e) =>
      if $(e.currentTarget).hasClass('selected')
        $(e.currentTarget).removeClass('selected')
      else
        $(e.currentTarget).addClass('selected')

      @refreshMap()

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

  prepareType: ->
    $('span.institutional').click =>
      $("#bloods").hide 'bounce', 1000, typeClicked
      $('span.institutional').addClass 'selected'

      @refreshMap()

    $('span.donor').click =>
      $('span.institutional').removeClass 'selected'
      $("#bloods").show 'bounce', 1000,
        $('h4.blood_type').text('Tipo de plasma').text('Tipo de plasma')
        $('span.institutional').css
            opacity: '1'
            cursor: 'pointer'
      @refreshMap()

  typeClicked = ->
    $('h4.blood_type').text('Clicando abaixo:')
    $('span.institutional').css
      opacity: '0.2'
      cursor: 'none'

  mapEvents: ->
    # google.maps.event.addListener Gmap.create(), 'dragend', =>
    #   @position = [Gmap.create().getCenter().Xa, Gmap.create().getCenter().Ya]
    #   Marker.centralizeUserMarker @position
    #   @refreshMap()

    google.maps.event.addListener Gmap.create(), 'click', (event) =>
      @position = [event.latLng.Xa, event.latLng.Ya]
      Marker.centralizeUserMarker @position
      @refreshMap()

  markerEvents: ->
    google.maps.event.addListener Marker.userMarker(), 'dragend', (event) =>
      @position = [event.latLng.Xa, event.latLng.Ya]
      @refreshMap()

  prepareAutocomplete: ->
    @autocomplete = new google.maps.places.Autocomplete(document.getElementById('searchBox'))
    @autocomplete.bindTo('bounds', Gmap.create())

    google.maps.event.addListener @autocomplete, 'place_changed', =>
      place = @autocomplete.getPlace()
      return unless place.geometry

      @position = [place.geometry.location.Xa, place.geometry.location.Ya]
      Gmap.centralize @position
      Marker.centralizeUserMarker @position
      @refreshMap()

  find: ->
    @query.abort() if @query != undefined

    @query = $.ajax
      url: 'find_elements_to_map'
      type: 'POST'
      data: $.extend {position: {lat: @position[0], lng: @position[1]}}, @filters()
      success: (data) => @onSuccess data
      error: (xhr, error)  -> console.log xhr, error

  clearMap: ->
    CompanyList.list().map (company) ->
      company.marker.setMap(null)

    PersonList.list().map (person) ->
      person.marker.setMap(null)

    CompanyList.clear()
    PersonList.clear()

  refreshMap: ->
    @clearMap()
    @find()

  onSuccess: (options) ->
    #companies
    options.companies.map (company) =>
      if @companyExists(company) == -1
        marker = Marker.company([company.lat, company.lng])
        CompanyList.add {id: company.id, marker: marker}

    #peopler
    options.people.map (person) =>
      if @personExists(person) == -1
        marker = Marker.person([person.lat, person.lng])
        PersonList.add {id: person.id, marker: marker}

  personExists: (person) ->
    PersonList.list().map((person)->person.id).indexOf(person.id)

  companyExists: (company) ->
    CompanyList.list().map((company)->company.id).indexOf(company.id)
