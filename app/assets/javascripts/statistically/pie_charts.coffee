class window.PieCharts
    constructor: (options, series) ->

      new Highcharts.Chart
        chart:
          renderTo: options.element
          plotBackgroundColor: null
          plotBorderWidth: null
          plotShadow: false

        tooltip:
          pointFormat: '{series.name}: <b>{point.percentage}%</b>',
          percentageDecimals: 2

        title:
          text: options.titleText

        plotOptions:
          pie:
            allowPointSelect: true
            cursor: 'pointer'
            dataLabels:
              enabled: true
              color: '#000000'
              connectorColor: '#000000'
              formatter: ->
                "<b> #{ this.point.name } </b>: #{ this.percentage.toFixed(2) } %"

        series: [series]