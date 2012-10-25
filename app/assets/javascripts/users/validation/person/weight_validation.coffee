class window.WeightValidation extends BaseValidation
  constructor: ->
    super('#person_weight')

  run: ->
    if is_blank(@field)
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')