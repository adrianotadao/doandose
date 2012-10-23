class window.AuthKeyValidation extends BaseValidation
  constructor: ->
    auth_key = 'input#auth_key'
    super(auth_key)

    $(auth_key).change (e) ->
      value = $(e.currentTarget).val().replace(/\s/g, '')
      $(e.currentTarget).val( value.toLowerCase() )

  run: ->
    expReg = /^([a-zA-Z0-9\.\-\+]+[a-zA-Z0-9._-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
    isEmailFormat = /\@/

    if isEmailFormat.test(@field.val())
      switch
        when @field.val().length > 100
          @setStatus('error', "E-mail excedeu #{@field.val().length - 100} caracteres")
        when !expReg.test(@field.val())
          @setStatus('error', 'Formato de e-mail inválido')
        else
          @setStatus('valid')
    else
      switch
        when @field.val() == ''
          @setStatus('error', 'Digite seu apelido ou e-mail')
        when @field.val().length < 4
          @setStatus('error', 'Mínimo 4 caracteres')
        when @field.val().length > 30
          @setStatus('error', "Username excedeu #{@field.val().length - 30} caracteres")
        when @field.val().match(/\s/gi)
          @setStatus('error', 'Caracteres inválido')
        else
          @setStatus('valid')

