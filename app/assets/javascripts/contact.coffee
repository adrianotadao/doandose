class window.Contact
  constructor: ->
    @name = $('#circle_three input.name')
    @email = $('#circle_three input.email')
    @subject = $('#circle_three input.subject')
    @message = $('#circle_three input.message')
    @buttonSend = $('#circle_three .submit')
    @changed = true

    @change()
    @buttonSend.click => @send() if @changed == true

    $('#circle_three input, textarea').keypress =>
      @hideInformation()

  send: ->
    $.ajax
      type: 'POST'
      url: '/send_email/'
      data: contact: @params()
      success: (data) =>
        if data == true
          @sucess()
        else
          @error(data)
      complete: (data) =>
          @complete(data.responseText == true)

  params: ->
    {
      name: @name.val()
      email: @email.val()
      subject: @subject.val()
      message: @message.val()
    }

  error: (messages) =>
    switch
      when messages.name != undefined && messages.name.length > 0
        $( @tooltip(messages.name[0]) ).insertAfter(@name)
        @changed = false

      when messages.email != undefined && messages.email.length > 0
        $( @tooltip(messages.email[0]) ).insertAfter(@email)
        @changed = false

      when messages.subject != undefined &&  messages.subject.length > 0
        $( @tooltip(messages.subject[0]) ).insertAfter(@subject)
        @changed = false

      when messages.message != undefined &&  messages.message.length > 0
        $( @tooltip(messages.message[0]) ).insertAfter(@message)
        @changed = false

      else
        $( @tooltip('Erro desconhecido') ).insertAfter(@message)
        @changed = false

  sucess: ->
    @buttonSend.attr('disabled', true)
    @buttonSend.addClass('disabled_submit')
    @buttonSend.attr('value', " #{ @buttonSend.attr('value') } ...")

  complete: (response) ->
    if response
      @name.val('')
      @email.val('')
      @subject.val('')
      @message.val('')
      @buttonSend.attr('disabled', false)
      @buttonSend.addClass('submit')
      @buttonSend.attr('value', "Enviar")
      alert 'enviado com sucesso !!!'

  tooltip: (message) ->
    $('#circle_three .information').remove()
    "<div class='information'>#{message}</div>" if $('#circle_three .information').length == 0

  change: ->
    $('#circle_three input').change =>
        @changed = true

  hideInformation: ->
    $('.information').hide()