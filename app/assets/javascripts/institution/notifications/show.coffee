class window.ShowNotification
  constructor: ->
    $('input.particpated').change (e) =>
      $(e.currentTarget).is(':checked')
      $.ajax
        url: "/instituicao/person_notifications/#{$(e.currentTarget).val()}/participation"
        type: 'POST'
        data: { participated: $(e.currentTarget).is(':checked') }
        success: (data) =>
          console.log data
        error: (data) =>
          alert 'Occorreu um erro ao tentar salvar'