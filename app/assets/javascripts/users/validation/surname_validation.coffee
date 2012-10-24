class window.SurnameValidation extends BaseValidation
  constructor: ->
    surname = '#person_surname'
    super(surname)

  run: ->
    if @field.val() == ''
      @setStatus('error', 'Digite seu sobrenome')
    else
      @setStatus('valid')