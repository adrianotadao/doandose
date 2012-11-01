class window.BarCharts
  constructor: (options) ->
    new Highcharts.Chart
      chart:
        renderTo: options.element
        type: "column"

      title:
        text: options.title

      subtitle:
        text: options.subtitle

      xAxis:
        categories: options.categories

      yAxis:
        min: 0
        title:
          text: ""

      tooltip:
        formatter: ->
          " #{ this.series.name } : #{ this.y } ou #{ Math.round(this.percentage) } % da quantidade"

      plotOptions:
        column:
          stacking: 'percent'

      series: options.series