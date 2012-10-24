class window.SurnameValidation extends BaseValidation
  constructor: ->
    surname = '#person_surname'
    super(surname)

  run: ->
    switch
      when @field.val() == '' then @setStatus('error', 'Digite seu sobrenome')
      else
        @setStatus('valid')