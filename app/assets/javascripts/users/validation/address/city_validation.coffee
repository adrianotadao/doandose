class window.CityValidation extends BaseValidation
  constructor: ->
    super('input.city')

  run: ->
    if is_blank(@field)
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')