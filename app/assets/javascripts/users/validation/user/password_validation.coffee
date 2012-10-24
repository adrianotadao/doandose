class window.PasswordValidation extends BaseValidation
  constructor: (input='') ->
    if input
      super(input)
    else
      super('#person_user_attributes_password')

    @currentPassword = $('#person_user_attributes_password')
    @passwordConfirmation= $('#person_user_attributes_password_confirmation')

  run: ->
    switch
      when @field.val() == '' then  @setStatus('error', 'Preencha sua senha')
      when @field.val().length < 6 && @field.val().length > 0 then @setStatus('error', 'Deve conter 6 dígitos')
      when @field.val().length > 12 then @setStatus('error', 'Excedeu 12 dígitos')
      when @passwordConfirmation.val() != '' && @field.val() != @passwordConfirmation.val()
        @lastValue = ''
        @setStatus('error', 'Senhas não conferem.')
      else @setStatus('valid')