class window.CurrentPasswordValidation extends BaseValidation
  constructor: ->
    super('#users_user_current_password')
    @request = undefined

  run: ->
    switch
      when @field.val() == '' then @setStatus('error', 'Não pode ficar em branco')
      when @field.val().length < 6 then @setStatus('error', 'Deve conter 6 dígitos')
      else
        @setStatus('pending')
        @request.abort() if @request?
        @request = $.ajax
          type: 'POST'
          url: '/cadastro/senha-atual-nao-confere/'
          data: current_password: @field.val()
          beforeSend: =>
            @setStatus('pending', 'Aguarde...')
          success: (data) =>
            if data
              @setStatus('valid')
            else
              @setStatus('error', 'senha inválida')
          complete: (data) =>
            @removeLoading()