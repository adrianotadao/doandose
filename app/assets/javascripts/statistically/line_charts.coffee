class window.LineCharts
  constructor: (options) ->
    @pointStart = options.pointStart
    @pointInterval = options.pointInterval
    @data = options.data
    @element = options.element

    @navigation()
    @lineCharts()

  navigation: ->
    @interval = [3, 0]
    $('span.more').click => @next()
    $('span.less').click => @previous()
    $('span.restore').click => @restore()

  next: ->
    @interval = [ @interval[0] -= 3,  @interval[1] -= 3 ]
    @pointStart += 1814400000
    @request()

  previous: ->
    @interval = [ @interval[0] += 3,  @interval[1] += 3 ]
    @pointStart -= 1814400000
    @request()

  restore: ->
    @interval = [3, 0]
    @pointStart = 1350097200000
    @request()

  request: ->
    $.ajax
      type: 'POST'
      url: 'estatistica/cadastro-por-dia/'
      data:
        start_at: @interval[0]
        end_at: @interval[1]
      beforeSend: =>
        addLoad('#tab-1')
      success: (data) =>
        if data
          @data[1] = data
          @lineCharts()
        else
          alert 'erro inexperado aguarde a pagina sera recarregada novamente !'
          location.reload()
        removeLoad('#tab-1')

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

  lineCharts: =>
    new Highcharts.Chart
      chart: { renderTo: @element }
      title: { text: 'Cadastro por dia' }
      xAxis: { type: 'datetime' }
      yAxis:
        title: { text: 'quantidade' }
      series: @series()