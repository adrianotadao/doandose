class window.SurnameValidation extends BaseValidation
  constructor: ->
    super('#person_surname')

  run: ->
    if is_blank(@field)
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')