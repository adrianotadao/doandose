class window.PasswordConfirmationValidation extends BaseValidation
  constructor: ->
    super('#users_user_password_confirmation')
    @password = $('#users_user_password')

  run: ->
    if @field.val() == ''
      return @setStatus('error', 'Confirme a senha')
    else
      return @setStatus('error', 'Senhas não conferem') if @field.val().length > 0 && @field.val() != @password.val()

    return @setStatus('valid')