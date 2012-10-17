class window.Navigator
  constructor: ->
    @query = undefined
    @position = []

    google.maps.event.addListener Gmap.create(), 'dragend', =>
      @position = [Gmap.create().getCenter().Xa, Gmap.create().getCenter().Ya]
      @find()

    @prepareAutocomplete()
    @bloodFilters()
    @distanceFilters()

  filters: ->
    bloodTypes = []
    for type in $('#filter_content #bloods span.selected')
      bloodTypes.push $(type).text()

    { blood_types: bloodTypes, distance: $('#filter_content #distances span.selected').text() }

  bloodFilters: ->
    $('#filter_content #bloods span').click (e) =>
      if $(e.currentTarget).hasClass('selected')
        $(e.currentTarget).removeClass('selected')
      else
        $(e.currentTarget).addClass('selected')

      @clearMap()
      @find()

  distanceFilters: ->
    $('#filter_content #distances span').click (e) =>
      $('#filter_content #distances span').removeClass('selected')
      $(e.currentTarget).addClass('selected')

      @clearMap()
      @find()

  prepareAutocomplete: ->
    @autocomplete = new google.maps.places.Autocomplete(document.getElementById('searchBox'))
    @autocomplete.bindTo('bounds', Gmap.create())

    google.maps.event.addListener @autocomplete, 'place_changed', =>
      place = @autocomplete.getPlace()
      return unless place.geometry

      @position = [place.geometry.location.Xa, place.geometry.location.Ya]
      Gmap.centralize @position
      @clearMap()
      @find()

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
