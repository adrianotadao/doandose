class window.WeightValidation extends BaseValidation
  constructor: ->
    super('#person_weight')

  run: ->
    if @field.val() == ''
      @setStatus('error', 'Digite seu peso')
    else if @field.val().length > 3
      @setStatus('error', 'Peso invalido')
    else
      @setStatus('valid')