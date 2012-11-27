class window.ShowPersonNotifications
  constructor: (id) ->
    @id = id
    @email = $('#alert_show #email .title')
    @sms = $('#alert_show #sms .title')

    @sms.click => @sendSms() unless @sms.hasClass 'disabled'
    @email.click => @sendEmail() unless @sms.hasClass 'disabled'

  sendSms: ->
    @call("/instituicao/person_notifications/#{@id}/send_sms")

  sendEmail: ->
    @call("/instituicao/person_notifications/#{@id}/send_email")

  call: (url) ->
    $.ajax
      url: url
      type: 'POST'
      success: (data) => window.location.reload()
      error: (data) => console.log 'ERRO'