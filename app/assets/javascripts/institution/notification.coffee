class window.Notification
  constructor: ->
    @request = undefined
    @buttonFilter = $('#buttonFilter')

    @prepareBloods()
    @prepareDistances()

    @buttonFilter.click => @find()

  prepareBloods: ->
    @bloods = $('#bloods span')
    @bloods.click (e) =>
      @bloods.removeClass 'selected'
      $(e.currentTarget).addClass 'selected'

  prepareDistances: ->
    @distances = $('#distances span')
    @distances.click (e) =>
      @distances.removeClass 'selected'
      $(e.currentTarget).addClass 'selected'

  find: ->
    @query.abort() if @query != undefined
    @request = $.ajax
      url: '/find_elements_to_notification'
      type: 'POST'
      data: $.extend { position: {lat: window.user.lat(), lng: window.user.lng()}}, @filters()
      success: (data) => @onSuccess data
      error: (xhr, error) -> console.log xhr, error

  filters: ->
    { bloods: $('#bloods span.selected').text(), distance: $('#distances span.selected').text() }

  onSuccess: (data) ->
    html = '<ul>'
    data.people.map (person) ->
      html += "<li>#{person.name} - #{person.address}</li>"
    html += '</ul>'
    $('#result').html html
