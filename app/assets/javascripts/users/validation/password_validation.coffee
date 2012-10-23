class window.PasswordValidation extends BaseValidation
  constructor: (input='') ->
    if input
      super(input)
    else
      super('#users_user_password')

    @currentPassword = $('#users_user_current_password')
    @passwordConfirmation= $('#users_user_password_confirmation')

  run: ->
    switch
      when @field.val() == '' then  @setStatus('error', 'Preencha sua senha')
      when @field.val().length < 6 && @field.val().length > 0 then @setStatus('error', 'Deve conter 6 dígitos')
      when @field.val().length > 12 then @setStatus('error', 'Excedeu 12 dígitos')
      when @passwordConfirmation.val() != '' && @field.val() != @passwordConfirmation.val()
        @lastValue = ''
        @setStatus('error', 'Senhas não conferem.')
      when @field.val() == @currentPassword.val() then @setStatus('error', 'Igual a senha antiga')
      else @setStatus('valid')