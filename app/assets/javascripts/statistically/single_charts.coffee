class window.SingleCharts
  constructor: (options) ->
    @data = options.data
    @pointStart = options.pointStart
    @pointInterval = options.pointInterval

    new Charts(@series())

  series: ->
    [
      pointInterval: @pointInterval
      pointStart: @pointStart
      data: @data
    ]