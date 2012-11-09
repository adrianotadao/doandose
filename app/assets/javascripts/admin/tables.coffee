class window.Tables
  constructor: ->
    $('.list').dataTable(
      bJQueryUI: true,
      sPaginationType: "full_numbers",
      iDisplayLength: -1,
      iDisplayLength: 10,
      oLanguage: {
          sProcessing:   "Processando...",
          sLengthMenu:   "Mostrar _MENU_ registros",
          sZeroRecords:  "Não foram encontrados resultados",
          sInfo:         "Mostrando de _START_ até _END_ de _TOTAL_ registros",
          sInfoEmpty:    "Mostrando de 0 até 0 de 0 registros",
          sInfoFiltered: "(filtrado de _MAX_ registros no total)",
          sInfoPostFix:  "",
          sSearch:       "Buscar:",
          sUrl:          "",
          oPaginate: {
              sFirst:    "Primeiro",
              sPrevious: "Anterior",
              sNext:     "Seguinte",
              sLast:     "Último"
          }
      },
      aLengthMenu: [[25, 50, 100, -1], [25, 50, 100, "Todos"]]
    )