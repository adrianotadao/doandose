class window.PasswordConfirmationValidation extends BaseValidation
  constructor: ->
    super('#person_user_attributes_password_confirmation')
    @password = $('#person_user_attributes_password')

  run: ->
    if @field.val() == ''
      return @setStatus('error', 'Confirme a senha')
    else
      return @setStatus('error', 'Senhas não conferem') if @field.val().length > 0 && @field.val() != @password.val()

    return @setStatus('valid')