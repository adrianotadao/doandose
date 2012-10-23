class window.UsernameValidation extends BaseValidation
  constructor: ->
    username = '#person_name'
    super(username)
    @request = undefined

  run: ->
    switch
      when @field.val() == '' then @setStatus('error', 'Digite seu apelido')
      when @field.val().match(/\s/gi) then @setStatus('error', 'Contém espaços')
      when @field.val().length > 30 then @setStatus('error', "Excedeu #{@field.val().length - 30} caracteres")
      when @field.val().length < 4 then @setStatus('error', 'Mínimo 4 caracteres')
      else
        @setStatus('pending')

        @request.abort() if @request?
        @request = $.ajax
          type: 'POST'
          url: '/cadastro/apelido-em-uso/'
          data: username: @field.val()
          beforeSend: (data) =>
            @setStatus('pending')
          success: (data) =>
            if data
              return @setStatus('error', 'Apelido já existe')
            else
              return @setStatus('valid')
          complete: (responseText) =>
            @removeLoading()