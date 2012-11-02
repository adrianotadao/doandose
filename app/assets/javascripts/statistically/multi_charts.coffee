class window.MultiCharts
  constructor: (options) ->
    @pointStart = options.pointStart
    @pointInterval = options.pointInterval
    @data = options.data
    @element = options.element

    @navigation()

    new LineCharts(@element, @series())


  navigation: ->
    @interval = [3, 0]
    $('span.more').click => @next()
    $('span.less').click => @previous()
    $('span.restore').click => @restore()

  next: ->
    @interval = [ @interval[0] + 3,  @interval[1] + 3 ]
    @request()

  previous: ->
    @interval = [ @interval[0] - 3,  @interval[1] - 3 ]
    @request()

  restore: ->
    @interval = [3, 0]
    @request()

  request: ->
    $.ajax
      type: 'POST'
      url: 'estatistica/cadastro-por-dia/'
      data:
        start_at: @interval[0]
        end_at: @interval[1]

      beforeSend: =>
        console.log 'before'
      success: (data) =>
        if data
          @data[1] = data
          new LineCharts(@element, @series())
        else
          console.log 'vaxou'
      complete: (data) =>
        console.log 'completou'

  series: ->
    aux = []

    for data, i in @data[1]
      aux.push( {
        name: @data[0][i]
        pointInterval: @pointInterval
        pointStart: @pointStart
        data: data
      } )

    return aux