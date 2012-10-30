class window.MultiCharts
  constructor: (options) ->
    @pointStart = options.pointStart
    @pointInterval = options.pointInterval
    @data = options.data

    new Charts(@series())

  series: ->
    aux = []

    for data, i in @data[1]
      console.log data, i, @data[0]
      aux.push( {
        name: @data[0][i]
        pointInterval: @pointInterval
        pointStart: @pointStart
        data: data
      } )

    return aux