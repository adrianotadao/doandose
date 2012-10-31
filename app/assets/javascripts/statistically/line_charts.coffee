class window.LineCharts
  constructor: (element, series) ->

    new Highcharts.Chart
      chart: { renderTo: element }
      title: { text: 'Cadastro por dia' }
      xAxis: { type: 'datetime' }
      yAxis:
        title: { text: 'cadastro' }
      series: series