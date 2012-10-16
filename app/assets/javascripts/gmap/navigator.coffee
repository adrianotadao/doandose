class window.Navigator
  constructor: ->
    @query = undefined

    google.maps.event.addListener Gmap.create(), 'dragend', =>
      @find [Gmap.create().getCenter().Xa, Gmap.create().getCenter().Ya]

    @prepareAutocomplete()
    @prepareFilters()

  filters: ->
    for type in $('#filter_content #type span.selected')
      console.log type

  prepareFilters: ->
    $('#filter_content #type span').click (e) =>
      if $(e.currentTarget).hasClass('selected')
        $(e.currentTarget).removeClass('selected')
      else
        $(e.currentTarget).addClass('selected')

  prepareAutocomplete: ->
    @autocomplete = new google.maps.places.Autocomplete(document.getElementById('searchBox'))
    @autocomplete.bindTo('bounds', Gmap.create())

    google.maps.event.addListener @autocomplete, 'place_changed', =>
      place = @autocomplete.getPlace()
      return unless place.geometry

      Gmap.centralize [place.geometry.location.Xa, place.geometry.location.Ya]
      @find [place.geometry.location.Xa, place.geometry.location.Ya]

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
