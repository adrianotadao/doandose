class window.PieCharts
    constructor: (element) ->

      new Highcharts.Chart
        chart:
          renderTo: 'percentage_blood_of_type'
          plotBackgroundColor: null
          plotBorderWidth: null
          plotShadow: false

        tooltip:
          pointFormat: '{series.name}: <b>{point.percentage}%</b>'
          percentageDecimals: 1

        plotOptions:
          pie:
            allowPointSelect: true
            cursor: 'pointer'
            dataLabels:
              enabled: true
              color: '#000000'
              connectorColor: '#000000'
              formatter: ->
                "<b> #{ this.point.name } </b>: #{ this.percentage } %"

        series: [element]