class window.HeightValidation extends BaseValidation
  constructor: ->
    super('#person_height')

  run: ->
    if is_blank(@field)
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')