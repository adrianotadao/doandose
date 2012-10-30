class window.Charts
  constructor: (series) ->
    new Highcharts.Chart
      chart: { renderTo: 'orders_chart' }
      title: { text: 'Cadastro por dia' }
      xAxis: { type: 'datetime' }
      yAxis:
        title: { text: 'cadastro' }
      series: series