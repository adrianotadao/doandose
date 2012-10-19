class window.Contact
  constructor: ->
    @name = $('#circle_three input.name')
    @email = $('#circle_three input.email')
    @subject = $('#circle_three input.subject')
    @message = $('#circle_three textarea.message')
    @buttonSend = $('#circle_three input:submit')
    @changed = undefined

    @change()
    @buttonSend.click => @send() if @changed == undefined || @changed == true

    $('#circle_three input, textarea').keypress => @hideInformation()

  send: ->
    $.ajax
      type: 'POST'
      url: '/send_email/'
      data: contact: @params()
      beforeSend: =>
        disabledSubmit( @buttonSend )
      success: (data) =>
        if data == true
          @sucess()
        else
          @error(data)

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
        @changed = true
        $( @tooltip(messages.name[0]) ).insertAfter(@name)

      when messages.email != undefined && messages.email.length > 0
        @changed = true
        $( @tooltip(messages.email[0]) ).insertAfter(@email)

      when messages.subject != undefined &&  messages.subject.length > 0
        @changed = true
        $( @tooltip(messages.subject[0]) ).insertAfter(@subject)

      when messages.message != undefined &&  messages.message.length > 0
        @changed = true
        $( @tooltip(messages.message[0]) ).insertAfter(@message)

      else
        @changed = true
        $( @tooltip('Erro desconhecido') ).insertAfter(@message)

  sucess: =>
    alert 'enviado com sucesso !!!'
    @clear()
    enabledSubmit(@buttonSend)

  clear: ->
      @name.val('')
      @email.val('')
      @subject.val('')
      @message.val('')

  tooltip: (message) ->
    if @changed
      $('#circle_three .information').remove()
      enabledSubmit(@buttonSend)
      @changed = false
      "<div class='information'>#{message}</div>"

  change: ->
    $('#circle_three input').change =>
        @changed = true

  hideInformation: ->
    $('.information').hide()