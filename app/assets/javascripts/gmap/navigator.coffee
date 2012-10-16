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
    for type in $('#filter_content #type span.selected')
      bloodTypes.push $(type).text().toLowerCase()

    { blood_types: bloodTypes, distance: $('#filter_content #distance span.selected').text() }

  bloodFilters: ->
    $('#filter_content #type span').click (e) =>
      if $(e.currentTarget).hasClass('selected')
        $(e.currentTarget).removeClass('selected')
      else
        $(e.currentTarget).addClass('selected')

      @clearMap()
      @find()

  distanceFilters: ->
    $('#filter_content #distance span').click (e) =>
      $('#filter_content #distance span').removeClass('selected')
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
      url: 'elements_by_user_position'
      type: 'POST'
      data: $.extend {position: {lat: @position[0], lng: @position[1]}}, @filters()
      success: (data) => @onSuccess data
      error: (xhr, error)  -> console.log xhr, error

  clearMap: ->
    for company in CompanyList.list()
      company.marker.setMap(null)

    for person in PersonList.list()
      person.marker.setMap(null)

    CompanyList.clear()
    PersonList.clear()

  onSuccess: (options) ->
    #companies
    for company in options.companies
      if @companyExists(company) == -1
        marker = Marker.company([company.lat, company.lng])
        CompanyList.add {id: company.id, marker: marker}

    #peopler
    for person in options.people
      if @personExists(person) == -1
        marker = Marker.person([person.lat, person.lng])
        PersonList.add {id: person.id, marker: marker}

  personExists: (person) ->
    PersonList.list().map((person)->person.id).indexOf(person.id)

  companyExists: (company) ->
    CompanyList.list().map((company)->company.id).indexOf(company.id)
