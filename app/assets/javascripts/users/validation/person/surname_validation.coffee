class window.SurnameValidation extends BaseValidation
  constructor: ->
    super('#person_surname')

  run: ->
    if @field.val() == ''
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')