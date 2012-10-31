class window.MultiCharts
  constructor: (options) ->
    @pointStart = options.pointStart
    @pointInterval = options.pointInterval
    @data = options.data
    @element = options.element

    new LineCharts(@element, @series())

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